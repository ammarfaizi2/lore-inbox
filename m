Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVK2REh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVK2REh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 12:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVK2REh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 12:04:37 -0500
Received: from kirby.webscope.com ([204.141.84.57]:6849 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932230AbVK2REg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 12:04:36 -0500
Message-ID: <438C8A15.60201@m1k.net>
Date: Tue, 29 Nov 2005 12:04:21 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Frost <sfrost@snowman.net>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C0124.3030700@m1k.net> <Pine.LNX.4.64.0511290808510.3177@g5.osdl.org> <438C80DD.7050809@m1k.net> <Pine.LNX.4.64.0511290835220.3177@g5.osdl.org> <20051129164946.GP6026@ns.snowman.net>
In-Reply-To: <20051129164946.GP6026@ns.snowman.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Frost wrote:

>* Linus Torvalds (torvalds@osdl.org) wrote:
>  
>
>>On Tue, 29 Nov 2005, Michael Krufky wrote:
>>    
>>
>>>In other words, the OOPS is the last thing to show on the screen in text mode,
>>>before the console switches into X, using debian sarge's default bootup
>>>process.
>>>      
>>>
>>Ok. Whatever it is, I'm happy it is doing that, since it caused us to see 
>>the oops quickly. None of _my_ boxes do that, obviously (and I tested on 
>>x86, x86-64 and ppc64 exactly to get reasonable coverage of what different 
>>architectures might do - but none of the boxes are debian-based).
>>    
>>
>I'm pretty curious about it too, none of my debian-based boxes have
>'gdb' anywhere in /etc/init.d.  The only thing I see is that the shell
>script /usr/bin/mozilla-firefox calls gdb when passed '--debugger', or
>when the DEBUG environment variable is set...  Perhaps he's doing that
>during his .xsession?
>  
>
I don't think that the .xsession can be involved, here..... The oops 
happens BEFORE user login, and firefox definately isn't loaded before 
logging in. ;-)

Anyhow, I forgot to mention that I am using the debian/testing sarge apt 
repository ... Once again, I have a purely default configuration, with 
the exception of the kernel.  When I get home, I'll grep through my 
startup scripts... I'll let you guys know what I find.

Cheers,

Mike
