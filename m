Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVIQQWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVIQQWq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 12:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVIQQWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 12:22:46 -0400
Received: from main.gmane.org ([80.91.229.2]:27015 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750930AbVIQQWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 12:22:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [i386 BOOT CODE] kernel bootable again
Date: Sat, 17 Sep 2005 18:19:29 +0200
Message-ID: <hhumctao447z.1cmhqs2q8ab2s.dlg@40tude.net>
References: <33542.85.68.36.53.1126619176.squirrel@212.11.36.192> <432722A1.8030302@tuxrocks.com> <43272B9D.1030301@zytor.com> <33296.85.68.36.53.1126690932.squirrel@212.11.36.192> <1rhnij9opqgby$.4jlz2jfqsmkc$.dlg@40tude.net> <9a8748490509170856a1b9428@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-48-14.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Sep 2005 17:56:08 +0200, Jesper Juhl wrote:

>> This is probably a stupid suggestion, but here it goes anyway: the
>> kernel has to be written on disk by something, right?
>> 
>> So if the "something" knows (or can get to know) the sector/tracks
>> layout of the disk it's writing the kernel onto, it could store this
>> information in the bootblock (is there space for that?). The bootblock
>> code would then just read this info and use it.
>> 
>> Of course, this would mean that making a kernel-bootable floppy
>> wouldn't be as simple as cp'ing the kernel image to /dev/fdwhatever,
>> but if a script/program designed to do this was included with the
>> kernel source (it wouldn't be too big ...) ...
>> 
> I may be missing something here, but if you are going to do something
> like that, then why not just use a real bootloader instead?

I'm not too much into this stuff, I don't even know the technical 
differences betwen booting from kernel-on-floppy or from a bootloader. 
My proposal was just to work around the "what's the track layout" 
issue in the kernel-on-floppy direct boot. Maybe you could see it like 
a delayed bootloader process ... don't know.

But as I mentioned, it was probably just a stupid suggestion :)

-- 
Giuseppe "Oblomov" Bilotta

Axiom I of the Giuseppe Bilotta
theory of IT:
Anything is better than MS

