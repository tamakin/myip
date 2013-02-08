#!/usr/bin/env ruby
require "bundler/setup"
require "systemu"

module Myip
  def self.get(interface)
    res = systemu "ifconfig #{interface}"
    ip = res[1].scan(/.*inet addr:(\S*).*/i)[0]
    {interface: interface, ip: ip ? ip[0] : ip}
  end
end

if __FILE__ == $0
  ARGV[0] ||= "eth0"
  res = Myip.get ARGV[0]
  puts "#{res[:interface]} : #{res[:ip] || 'not found'}"
end
