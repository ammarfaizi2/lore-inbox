Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUALRAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUALRAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:00:32 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:22453 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S266213AbUALRAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:00:21 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Date: Mon, 12 Jan 2004 12:00:19 -0500
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, thomas@winischhofer.net,
       linux-kernel@vger.kernel.org, jsimmons@infradead.org
References: <20040109014003.3d925e54.akpm@osdl.org> <200401120121.12122.gene.heskett@verizon.net> <20040112163357.GA20815@redhat.com>
In-Reply-To: <20040112163357.GA20815@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401121200.19166.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.56.190] at Mon, 12 Jan 2004 11:00:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 January 2004 11:33, Dave Jones wrote:
>On Mon, Jan 12, 2004 at 01:21:12AM -0500, Gene Heskett wrote:
> > DRM? lemme see if thats even turned on.  Nope "# CONFIG_DRM is
> > not set" Doing a make xconfig, I see that if I turn it on, there
> > is not a driver for my gforce2/nvidia, so I naturally turned it
> > back off.
> >
> > I do have VIA and agpgart enabled just above it
>
>With CONFIG_DRM off, the AGP options may as well be turned off too,
>as they do nothing[1] on a system without 3d acceleration.
>
>		Dave
>
>[1] Well, unless you have an Intel i8xx chipset where you need it
> for the horrid framebuffer needs memory through GART hack.
>	And in your case, you don't have one of these.

Are you saying I should turn it on, but just not select a specific 
makers chip-boardset?  Or that I should go get a different card?

In which case I'd have about an 80 dollar limit as I'm not a game 
player that needs a 500 dollar video card.  OTOH, as long as I stay 
the hell away from nvidias own drivers, this card has been quite 
bulletproof.  The only thing thats missing is the GLX extensions.

The last time I brought an ATI card home, the box carried no 
indication that it was anything but what it said it was.  But it 
couldn't be made to work, new vendor/product code return.  I called 
ATI on my quarter and was told rather snippishly that it worked fine 
with their windows drivers that were on the cd, and that if I wanted 
support, I had to be running windows.  So I bought a driver from 
xorg, didn't work, same problem, except no refund was available.  I 
got snotty, and they did too.  Screw both of 'em, and the camels that 
rode in on them,  That left nvidia as the other major player, so 
thats what I bought with my refund.  It worked right out of the box.

tvtime, even running full screen, runs just fine here on this old 
card, as does the vlc stuff, but thats the extent of my requirements 
for full motion video.

But, I'm thinking of building another, and certainly open for video 
card suggestions within the 'utility' price range.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

