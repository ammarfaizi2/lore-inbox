Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbVKGSPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbVKGSPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbVKGSPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:15:54 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:48877 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965176AbVKGSPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:15:53 -0500
Subject: Re: 3D video card recommendations
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Knecht <markknecht@gmail.com>
Cc: Gerhard Mack <gmack@innerfire.net>, LKML <linux-kernel@vger.kernel.org>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hugo Mills <hugo-lkml@carfax.org.uk>, Nix <nix@esperi.org.uk>,
       Anshuman Gholap <anshu.pg@gmail.com>, Diego Calleja <diegocg@gmail.com>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>, arjan@infradead.org
In-Reply-To: <5bdc1c8b0511071001s2d990e72s812c195d5614a894@mail.gmail.com>
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <1131349343.2858.11.camel@laptopd505.fenrus.org>
	 <1131367371.14381.91.camel@localhost.localdomain>
	 <20051107152009.GA20807@shuttle.vanvergehaald.nl>
	 <20051107180045.ec86a7f2.diegocg@gmail.com>
	 <1131384624.14381.106.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511071243350.9444@innerfire.net>
	 <1131386032.14381.110.camel@localhost.localdomain>
	 <5bdc1c8b0511071001s2d990e72s812c195d5614a894@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 07 Nov 2005 13:15:17 -0500
Message-Id: <1131387317.14381.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 10:01 -0800, Mark Knecht wrote:

Mark thanks for the update.

> 
> Steven,
>   Hi . I run my ATI PCI_Express card on a 64-bit kernel. (2.6.14-rt6)
> It works fine for my needs, although as I said earlier my glxgears
> numbers are nothing to shout about:
> 
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV370
> 5B60 [Radeon X300 (PCIE)]
> 0000:01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
> 
> mark@lightning ~ $ glxgears
> Xlib:  extension "XFree86-DRI" missing on display ":0.0".
> 3170 frames in 5.0 seconds = 634.000 FPS
> 3416 frames in 5.0 seconds = 683.200 FPS
> 3294 frames in 5.0 seconds = 658.800 FPS

These aren't too shabby, but then again compared to my NVidia (non-rt
obviously) with their binary driver):

0000:01:05.0 VGA compatible controller: nVidia Corporation NV40 [GeForce
6800 GT] (rev a1)

$ glxgears
49961 frames in 5.0 seconds = 9992.200 FPS
48599 frames in 5.0 seconds = 9719.800 FPS
55592 frames in 5.0 seconds = 11118.400 FPS
47395 frames in 5.0 seconds = 9479.000 FPS

What do you get with the ATI binary driver?

> 
> mark@lightning ~ $
> 
>    I'm using the radeon driver from the Xorg-X11 package. The only
> problem I've run into which remains unsolved is that when I run either
> Quicken or IE6 under Crossover Office 5.0 all of the icons in those
> windows programs show up in black and white, not color, so they are
> somewhat unreadable. Other than that no real problems.
> 

Sorry, I can't help you there. I don't have access to IE or Quicken
(well, it's on my wife's computer, but she won't let me put Linux on
it! :-(

-- Steve


