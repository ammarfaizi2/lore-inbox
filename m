Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271826AbRILVmE>; Wed, 12 Sep 2001 17:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271808AbRILVly>; Wed, 12 Sep 2001 17:41:54 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:9988 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S271795AbRILVlp>;
	Wed, 12 Sep 2001 17:41:45 -0400
Message-ID: <20010911005848.A1005@bug.ucw.cz>
Date: Tue, 11 Sep 2001 00:58:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>, Simon Hay <simon@haywired.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple monitors
In-Reply-To: <20010903214829.B17488@unthought.net> <Pine.LNX.4.33.0109032107280.2297-100000@localhost.localdomain> <20010907015556.A7329@kushida.degree2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010907015556.A7329@kushida.degree2.com>; from Jamie Lokier on Fri, Sep 07, 2001 at 01:55:56AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Also, though, on dedicated servers etc. I'd rather not be running X if
> > I didn't have to.
> 
> You may find that a full screen xterm, with no window manager, actually
> runs much faster than the console and looks identical.  It is certainly
> the case on several of my machines.
> 
> This is most pronounced if X can do hardware acceleration on your video
> card, although it is true even without acceleration because of xterm's
> nice jump scroll capability.  (Btw, I prefer gnome-terminal because of
> the Linux-console colour emulation :-).
> 
> On one 686 class machine, I saw text mode take nearly two seconds to
> scroll the screen, when all but one line of the screen was being
> scrolled (so it had to copy everything).  This was in pure text mode,
> not even a framebuffer!  In X it was invisibly fast.

2 seconds on vga console is way too much. It could happen with
framebuffer + usb hogging PCI...
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
