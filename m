Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbTEOTkw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264204AbTEOTkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:40:52 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:55683 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S264198AbTEOTkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:40:49 -0400
Message-ID: <3EC3F02E.1010604@cox.net>
Date: Thu, 15 May 2003 15:53:18 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB not accepting addresses in bk9
References: <3EC310C3.9060606@cox.net> <20030515070800.GA6497@kroah.com>
In-Reply-To: <20030515070800.GA6497@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, May 15, 2003 at 12:00:03AM -0400, David van Hoose wrote:
> 
>>Sometime between 2.5.69-bk4 and 2.5.69-bk8, something with related to 
>>the USB was messed up. I get the below lines in my dmesg.
>>hub 2-0:0: new USB device on port 1, assigned address 2
>>usb 2-1: USB device not accepting new address=2 (error=-110)
>>hub 2-0:0: new USB device on port 1, assigned address 3
>>usb 2-1: USB device not accepting new address=3 (error=-110)
>>
>>The first device is my Logitech Cordless Optical Trackball.
>>The second device is my TI USB Graphlink.
>>
>>The Trackball still works. Not sure about the graphlink as I don't have 
>>the software installed yet. :-/
> 
> How can the device work if the USB bus rejected it?  Also, does
> /proc/interrupts increment for the USB controller when you plug a device
> in?

No idea. It seems to increment the usb line in /proc/interrupts.
I've attached a dmesg with verbose debugging. Unplugged and plugged back 
in my USB devices twice to add to some extra info that may be helpful 
for debugging. The trackball works every time though so it isn't a 
blocking problem for me.

>>I used the same config for bk4 as I did for bk8. It've attached my 
>>config for bk9 since it is the same anyway.
> 
> Care to do a binary search of bk4 to bk8 to try to find the problem?
> Should only take you 2 reboots at most :)

What do you want me to do? I don't know if I have the skills yet to code 
for the kernel, so the least I can do is test it. :-)

Thanks,
David

