Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263033AbRFNOxf>; Thu, 14 Jun 2001 10:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbRFNOxZ>; Thu, 14 Jun 2001 10:53:25 -0400
Received: from draco.macsch.com ([192.73.8.1]:3247 "EHLO draco.macsch.com")
	by vger.kernel.org with ESMTP id <S263033AbRFNOxR>;
	Thu, 14 Jun 2001 10:53:17 -0400
Message-ID: <3B28CFBF.4B7639D2@mscsoftware.com>
Date: Thu, 14 Jun 2001 07:52:47 -0700
From: "David N. Lombard" <david.lombard@mscsoftware.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-8.msc-up i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Juri Haberland <juri@koschikode.com>
CC: georgn@somanetworks.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5-ac13, APM, and Dell Inspiron 8000
In-Reply-To: <20010614090738.30539.qmail@babel.spoiled.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juri Haberland wrote:
> 
> You wrote:
> >
> > I've been running 2.4.5 on my new Dell I8000 without too many
> > problems.  Last night I built -ac13 (on my porch) and booted it
> > without incident.  Later, going inside and re-connecting the AC I
> > notice that the thing's hung.  I play around a bit and discover that
> > the act of plugging or unplugging the power cord will hang the box.
> >
> > This lead me to disable all power manglement in the BIOS.  No joy.
> >
> > This problem does not exist using straight 2.4.5.
> >
> > Has anybody else seen this?  Any debugging suggestions?  Or stated
> > differently, has anybody with this machine arrived at a configuration
> > that avoids weirdness in the power management framework?
> 
> Ok, I just tried that and my i8000 locked up as well. No problems with
> 2.4.5 as well. I have also another problem:
> Running with -ac13 it doesn't poweroff properly - but it did running
> 2.4.5. Sometimes it just stops where it should poweroff and locks hard,
> sometimes it blanks the display before locking up hard.

The Dell i5000e crashes when switching between mains and battery when
the disk is active, so you might try to plug/unplug with the system
quiet.

If this works, you'll be in a *little* better spot.

As for hanging, you might try suspending it (i.e., close the display)
and opening it back up.  This works for the i5000e; it also clears the
display that sometimes goes *nuts* when switching video modes.  This
last behavior has only surfaced with the latest A06 BIOS.

-- 
David N. Lombard
