Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266246AbRF3S1J>; Sat, 30 Jun 2001 14:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266247AbRF3S07>; Sat, 30 Jun 2001 14:26:59 -0400
Received: from mail.myrio.com ([63.109.146.2]:34547 "EHLO mailx.myrio.com")
	by vger.kernel.org with ESMTP id <S266246AbRF3S0r>;
	Sat, 30 Jun 2001 14:26:47 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211C90F@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Daniel Stone'" <daniel@sfarc.net>, Christoph Zens <czens@coactive.com>
Cc: chuckw@altaserv.net, Aaron Lehmann <aaronl@vitelus.com>,
        Vipin Malik <vipin.malik@daniel.com>,
        David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: RE: Cosmetic JFFS patch.
Date: Sat, 30 Jun 2001 11:26:29 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc's trimmed a little.)

As someone who actually has created an embedded Linux distribution
for a set top box, I can say that the boot output has never been
a problem for me.   I like verbose output, it's useful.

Developers probably know that once you have the system booting 
nicely and you've quit messing with the kernel, you can put
APPEND = "console=/dev/tty2 CONSOLE=/dev/tty2"
in lilo.conf.

With framebuffer support and a custom, full screen boot logo, the 
graphics appear immediately after the kernel starts, and no text
ever appears on screen.  After init gets going, you can continue to 
dump text output to tty2 while you display pretty pictures in the 
framebuffer or start X.   

So, I can't see verbose text output being a problem for anyone 
developing for embedded systems... that memory is all freed after 
boot anyway.

So here's a real copyright / trademark / GPL question:

Suppose some embedded Linux system developer wants to put their 
trademarked, copyrighted logo on the screen during the boot.

So they compile it into the linux_logo.h image. It's now under the 
GPL, of course... what does that do to the legal status of the logo?   

Incidentally, the copyright and other messages have never bothered me.  

I figure if some company is going to do me the favor of sponsoring 
development of software I can use for free, I really don't mind being 
reminded of it.   MP3.com definitely scores karma points with me for 
sponsoring Reiser, for instance.

Torrey Hoffman

