Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVK2QZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVK2QZR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVK2QZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:25:16 -0500
Received: from kirby.webscope.com ([204.141.84.57]:60849 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932082AbVK2QZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:25:15 -0500
Message-ID: <438C80DD.7050809@m1k.net>
Date: Tue, 29 Nov 2005 11:25:01 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C0124.3030700@m1k.net> <Pine.LNX.4.64.0511290808510.3177@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511290808510.3177@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 29 Nov 2005, Michael Krufky wrote:
>  
>
>>Those memory problems affecting v4l/dvb seem to be fixed (for me) , and
>>everything seems to work, but I got this oops on bootup.  This is the first
>>2.6.15-rcX kernel that I've installed on this particular box.  2.6.14 worked
>>fine.
>>    
>>
>Ok, Nick's obviously correct patch fixed that, but now I wonder what the 
>_heck_ your bootup process does:
>
>>Process gdb (pid: 5628, threadinfo=f488e000 task=f7239a30)
>>    
>>
>what kind of _strange_ boot process has gdb in it? 
>
>Morbidly curious,
>
>		Linus
>  
>
Linus-

Good point... I don't know what is going on there.  That box is running 
a newly-installed debian sarge, with it's default startup scripts.  I 
have done nothing to that system besides kernel testing and v4l / dvb 
testing and development.

The oops was showing up immediately before xorg opens with it's 
user-login box...

In other words, the OOPS is the last thing to show on the screen in text 
mode, before the console switches into X, using debian sarge's default 
bootup process.

I have no idea why gdb is running.... hmm... Anyhow, I'm away from that 
machine right now, and it is powered off, so I can't look directly at 
the startup scripts right now.  Would you like me to send more info 
later on when I get home?  If so, what would you like to see?

Cheers,

Michael Krufky
