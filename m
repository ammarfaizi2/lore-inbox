Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263140AbTDBU4M>; Wed, 2 Apr 2003 15:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbTDBU4M>; Wed, 2 Apr 2003 15:56:12 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:48064 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S263140AbTDBU4K>; Wed, 2 Apr 2003 15:56:10 -0500
Message-ID: <3E8B5119.5000508@rcn.com>
Date: Wed, 02 Apr 2003 16:07:37 -0500
From: Mike Tangolics <mtangolics@rcn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Hall <matt@ecsc.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Kernel Framebuffer Problems
References: <E190QXQ-0004Uz-00@smtp01.mrf.mail.rcn.net> <1049282302.745.24.camel@sheeta>
In-Reply-To: <1049282302.745.24.camel@sheeta>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Hall wrote:

>On Tue, 2003-04-01 at 19:31, mtangolics@rcn.com wrote:
>  
>
>>I've had a couple of problems with framebuffer console, when 
>>compiling several different versions of the 2.5 kernel.  I 
>>included all the FB support, but when I boot up using, LILO 
>>option, vga=791 or anything about normal, the screen either 
>>goes black, and the system stops responding or the entire 
>>screen becomes scrambled.  I have an NVidia Geforce4 video 
>>card if that matters.  I've talked to a couple other users 
>>who have encountered the same problem.  It's most likely just 
>>a stupid mistake on my part, but any help would be extremely 
>>appreciated.
>>    
>>
>
>What does your lilo.conf line for 2.5 look like?
>You may need to append some video information, eg.
>
>append="video=rivafb,xres:1024,yres:768,bpp:8"
>
>Matt
>  
>
My lilo.conf line looks this generally:
I left out the minor numbers because I don't have a specific kernel 
running right now..

image=/boot/vmlinuz-2.5
root = /dev/hdb2
label = Linux-2.5
read-only

plus at the top:
vga=791


