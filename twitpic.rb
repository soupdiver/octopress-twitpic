# This is a Octopress/Jekyll plugin for easy embedding twitpic ressources.
# Author: Felix Gläske
# url: felix.sub-reality.org
# Date: 05.09.2012
# repo: https://github.com/soupdiver/octopress-twitpic
# 
# Usage: {% twitpic id %}
#
# Comments: Very basic right now but works fine for me. Maybe I will add some more features for customization or feel free to add them by yourself.


require 'json'
require 'net/http'

module Jekyll
	class Twitpic < Liquid::Tag
		@title = ''
		@id = ''
		@width = 0
		@height = 0
		@username = ''
		def initialize(tag_name, id, tokens)
			@id = id.strip
			response = Net::HTTP.get_response("api.twitpic.com","/2/media/show.json?id=" + id)
			json = JSON.parse response.body
			@title = json['message']
			@width = json['width']
			@height = json['height']
			@username = json['user']['username']
		end
		
		def render(context)
			"<a href=\"http://twitpic.com/#{@id}\" title=\"#{@title}\"><img src=\"http://twitpic.com/show/full/#{@id}.jpg\" width=\"#{@width}\" height=\"#{@height}}\" alt=\"#{@title}\"></a> <blockquote><p>#{@title}</p></blockquote><p>by <a href=\"https://twitter.com/#{@username}\">@#{@username}</a></p>"
		end
	end
end

Liquid::Template.register_tag('twitpic', Jekyll::Twitpic)