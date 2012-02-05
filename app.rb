require 'rubygems'
require 'sinatra'
require 'haml'
require 'digest/md5'

get '/' do
	haml :index
end

get '/upload' do
	haml :upload
end

post '/upload' do
	data = params['imagedata']
	hash = Digest::MD5.new(data).to_s

	open("./public/#{hash}.png", "wb+") do |f|
		f.write(data)
	end
	"http://#{request.host}:#{request.port}/#{hash}"
end

get '/:image_name' do
	haml :show
end
