Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbTJJRgS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTJJRgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:36:18 -0400
Received: from sea2-f11.sea2.hotmail.com ([207.68.165.11]:59912 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263005AbTJJRgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:36:10 -0400
X-Originating-IP: [129.128.161.249]
X-Originating-Email: [danielharker@hotmail.com]
From: "Daniel Harker" <danielharker@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: original redhat config
Date: Fri, 10 Oct 2003 11:36:08 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F11XoZl0fqWcH800005aac@hotmail.com>
X-OriginalArrivalTime: 10 Oct 2003 17:36:09.0206 (UTC) FILETIME=[FDA63960:01C38F54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

I've had quite a problem compiling my kernel lately  :).  I've spent maybe 2 
weeks day and night trying to just patch my kernel with the bootsplash patch 
found at bootsplash.org.

Originally, I downloaded the lastest stable kernel at www.kernel.org. 
2.4.22.  I tried to compile it on my Redhat 9 system, and for somereason or 
another it just wouldn't work.  I wonder if the new kernels work properly 
with redhat 9? Well that's not really my question per say.

I did finally get ahold of a kernel source for redhat 9, and recompiled it 
with the bootsplash patch. HURAY! but, when I rebooted, I got a nasty 
surprise! my USB mouse didn't work, my sound card didn't work and neither 
did my network card!

So naturally, I figured that what really happened was that when I compiled 
the kernel, it didn't use the configure that redhat 9 originally put on my 
system when it installed.  So, someone told me in an irc chat room that in 
the /boot directory I could find a .config file, and sure enough it was 
there!  So i recompiled my kernel with the .config file, and i rebooted 
hoping that it would work, and my USB mouse, networkcard, and soundcard 
didn't work!! :(

I think they are all modules.  My theory is that I must have accedently 
changed the .config file in the /boot directory that redhat put there when 
it installed my system, because let's face it, I attempted to recompile the 
kernel like 20 or 30 times.  :).  So the configuration didn't really work 
for my system anymore.

With university, it's really hard to find time to go through every little 
thing in the make menuconfig.  I know that if I spent hours and hours, I 
could figure out exactly what modules my mouse needs, what my network card 
and sound card needs, but I just don't have the time.

My question:  Is there a way (without reinstalling) to get the make 
menuconfig to use exactly what redhat configured for my system?  So that my 
mouse, soundcard, and network card work? I pretty much want it to be the 
exact same kernel configuration but with the bootsplash patch.

Can I run a program that will make a .config file for make menuconfig from 
the settings that I have on my computer?  Could i reinstall the redhat .rpm 
kernel file and maybe it would have the options for my system?

I really would like the answers to all of these questions.  Thank you so 
much for taking your time to read this and reply.

My email adress is:  danielharker@hotmail.com

Thankyou.

dan

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

