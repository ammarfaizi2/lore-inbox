Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSLAU4u>; Sun, 1 Dec 2002 15:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSLAU4u>; Sun, 1 Dec 2002 15:56:50 -0500
Received: from mx-out.ttys.com ([80.239.199.130]:36162 "EHLO
	fep02-svc.ttyl.com") by vger.kernel.org with ESMTP
	id <S262449AbSLAU4t>; Sun, 1 Dec 2002 15:56:49 -0500
From: Andy Jefferson <andy@ajsoft.freeserve.co.uk>
Reply-To: andy@ajsoft.net
Organization: AJSoft Limited
To: Joshua Kwan <joshk@mspencer.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Re: 2.4.20 DRM/DRI issue with Radeon
Date: Sun, 1 Dec 2002 21:04:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <20021201210413.TGWM5142.fep02-svc.ttyl.com@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've since been to dri.sourceforge.net and grabbed the latest drm-kernel source (ver 1.2 for XFree version 4.2) and built and built and installed it. Works fine with that !!. The version of drm-kernel in the kernel source for 2.4.20 is still the 1.1.1 version for some reason.
Perhaps they can be merged at some point in the future ?

Thx anyway

> I'm stumped, really. Try building it INTO the kernel (ie Y instead of
> M.) This is what I did and it works. Or maybe you should get XFree86
> 4.2.1, which is what I have: 
> XFree86 Version 4.2.1.1 (Debian 4.2.1-4 20021123003806
> branden@debian.org) / X Window System
> Hope things work out.
> -Josh
> Rabid cheeseburgers forced Andy Jefferson <andy@ajsoft.freeserve.co.uk>
> to write this on Sun, 1 Dec 2002 14:32:33 +0000:	
> > > > In the 2.4.20 kernel changelog I see comments about having
> > > > consistent DRM modules with XFree4.2.0. I have a Radeon Mobility
> > > > M6 LY in a Dell laptop and would like to get DRI working. Whenever
> > > > I use any 2.4.*(including 2.4.20) kernel I get the following
> > > > messages in/var/log/XFree86.0.log, and DRM is not enabled. Is this
> > > > supposed to be working in 2.4.20 ? I am using a Mandrake 8.2
> > > > system (except for the kernel).
> > > > (EE) RADEON(0): [dri] RADEONDRIScreenInit failed because of a
> > > > version mismatch.[dri] radeon.o kernel module version is 1.1.1 but
> > > > version 1.2.x is needed.[dri] see http://gatos.sf.net/ for an
> > > > updated module[dri] Disabling DRI.
> > 
> > 
> > > Works for me.
> > > Debian GNU/Linux unstable distribution
> > > 
> > > You did enable radeon DRM drivers in the kernel config right? For
> > > your chipset and for the Radeon, right?
> > 
> > Well, yes. I'm getting VERSION CONFLICT messages, and not that there
> > is no radeon.o module. For the record, what I get from dmesg is
> > 
> > Linux agpgart interface v0.99 (c) Jeff Hartmann
> > agpgart: Maximum main memory to use for agp memory: 203M
> > agpgart: Detected Intel i830M chipset
> > agpgart: AGP aperture is 256M @ 0xd0000000
> > [drm] AGP 0.99 on Unknown @ 0xd0000000 256MB
> > [drm] Initialized radeon 1.1.1 20010405 on minor 0
> > 
> > FWIW I have in the kernel
> > 
> > /dev/agpgart set to Module
> > I830M support set to Yes
> > Build old DRM 4.0 drivers set to No
> > DRM 4.1 ATI Radeon set to Module
> > 
> > So the version of the kernel module is 1.1.1 20010405 (with 2.4.19,
> > AND 2.4.20) , yet the XFree86 drivers need 1.2.* as per the original
> > message in the XFree86.0.log. Why is the kernel using 1.1.1 and not
> > 1.2.* ?
> > 
> > Thx
> > 
> > --
> > Andy
> > 
> > _____________________________________________________________________
> > __ Freeserve AnyTime, only £13.99 per month with one month's FREE
> > trial! For more information visit http://www.freeserve.com/time/ or
> > call free on 0800 970 8890
> > 
> 

--
Andy

_______________________________________________________________________
Freeserve AnyTime, only £13.99 per month with one month's FREE trial!
For more information visit http://www.freeserve.com/time/ or call free on 0800 970 8890


