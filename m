Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264391AbRFNBli>; Wed, 13 Jun 2001 21:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264392AbRFNBl2>; Wed, 13 Jun 2001 21:41:28 -0400
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:5115 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S264391AbRFNBlV>; Wed, 13 Jun 2001 21:41:21 -0400
Message-Id: <200106140141.f5E1fFL3012794@typhaon.pacific.net.au>
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Daniel <ddickman@nyc.rr.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die 
In-Reply-To: Message from Alan Olsen <alan@clueserver.org> 
   of "Wed, 13 Jun 2001 19:22:38 PDT." <Pine.LNX.4.10.10106131903190.16254-100000@clueserver.org> 
In-Reply-To: <Pine.LNX.4.10.10106131903190.16254-100000@clueserver.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 11:41:15 +1000
From: David Luyer <david_luyer@pacific.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Obsolete code must die.  Hardware support must live on.

> > ISA, MCA, EISA device drivers
> > If support for the buses is gone, there's no point in supporting devices for
> > these buses.
> 
> I am not certain if tis is a good idea, for the reason given above.  (Not
> certain about MCA and EISA though.)  

MCA is common for PS/2's, which are still around.

> > MFM/RLL/XT/ESDI hard drive support
> > Does anyone still *have* an RLL drive that works? At the very least get rid
> > of the old driver (eg CONFIG_BLK_DEV_HD_ONLY, CONFIG_BLK_DEV_HD_IDE,
> > CONFIG_BLK_DEV_XD, CONFIG_BLK_DEV_PS2)
> 
> I am not certain how much this stuff is still used outside the US.  The XT
> driver still being around does surprise me though.  (Will that even *work*
> on modern hardware?  I didn't think you could get that card to work on a
> 386.)

Could never get my OMTI 8627 ESDI controller to work under Linux when I tried.
It works under DOS/Win, Xenix and VSTa though.  These controllers were
pseudo-common early 386 machines (before the 386sx and 386dx) built for
Xenix.

Surprisingly the old NEC ESDI drive still spins up, when most of the 1998 or
1999 Seagates/IBM drives are dead or dying and we've had close to an entire
A1000 Sun disk unit fail to spin up -- the 'top-end' disks of today rarely
seem to last more than 2-3 years (in that if you turn them off after 2-3
years of continual service and turn them back on 1/2 hr later, half of the
drives which haven't spat out a drive head in the interim years will fail
to spin up).

Even old Eagle drives from 1988 still spin up... given you have to flick the
starter switch to spin them up half a dozen times, but they still work...
seems they don't make disk drives like they used to.

David.
-- 
David Luyer                                        Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C       Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T      Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                         NASDAQ:  PCNTF


