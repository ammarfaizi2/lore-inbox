Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131206AbRCWQXT>; Fri, 23 Mar 2001 11:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRCWQW7>; Fri, 23 Mar 2001 11:22:59 -0500
Received: from dentin.eaze.net ([216.228.128.151]:21252 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S131206AbRCWQWw>;
	Fri, 23 Mar 2001 11:22:52 -0500
Date: Fri, 23 Mar 2001 10:21:18 -0600 (CST)
From: SodaPop <soda@xirr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <egger@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Only 10 MB/sec with via 82c686b - FIXED
In-Reply-To: <E14gOAz-0004MB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103231016150.27068-100000@xirr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alan, but no dice.  Most of the stuff on the board is autodetect
anyway, but even after a reset it exhibited the same behaviour.

Windows, however, continues to run fine.  It's not properly set up with
all the various drivers installed though, so its probably running with the
equivalent of a 486 kernel as well.

I tried rebuilding with K6-II as the cpu type instead of K7, that works
fine.  Is there any data in particular you'd like me to collect or
experiments you'd like me to try?

-dennis T


On Fri, 23 Mar 2001, Alan Cox wrote:

> > Wonder of wonders, I flashed the bios to the latest and greatest version.
> > Current data transfer rates are 35.7 MB/sec on both udma drives, exactly
> > as expected and darn close to the continuous read limits of the disks.
> > The audio also started working, flawlessly.
> >
> > There are other issues however - the athlon now runs significantly hotter
> > at idle for one, but the most serious is that the K7 kernel optimizations
> > cause horrendous kernel panics and crashes.  I'm running now on a kernel
> > compiled for 386, which seems to be stable.  I'll attempt to build other
> > kernels to see if I can figure out whats going on.
>
> Check the bios update didnt leave some of the other configuration values
> wrong. A 'reset to factory defaults' and resetting the stuff you need might
> be a good idea. Could be it now has voltages wrong or something like that
>
> Alan
>

