Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262058AbRFNKoW>; Thu, 14 Jun 2001 06:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbRFNKoM>; Thu, 14 Jun 2001 06:44:12 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:1032 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261969AbRFNKnz>; Thu, 14 Jun 2001 06:43:55 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200106141025.MAA02059@kufel.dom>
Subject: Re: obsolete code must die
To: kufel!clueserver.org!alan@green.mif.pg.gda.pl (Alan Olsen)
Date: Thu, 14 Jun 2001 12:25:01 +0200 (CEST)
Cc: kufel!nyc.rr.com!ddickman@green.mif.pg.gda.pl (Daniel),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl (Linux kernel)
In-Reply-To: <Pine.LNX.4.10.10106131903190.16254-100000@clueserver.org> from "Alan Olsen" at cze 13, 2001 07:22:38 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 13 Jun 2001, Daniel wrote:
> > MFM/RLL/XT/ESDI hard drive support
> > Does anyone still *have* an RLL drive that works? At the very least get rid

RLL ? Curently no. But I have a dosen of working ST225 with a dosen of ST11M
MFM controllers. Some of them ar\e still in use, mainly for booting purposes
(LILO) ... 

> > of the old driver (eg CONFIG_BLK_DEV_HD_ONLY, CONFIG_BLK_DEV_HD_IDE,
> > CONFIG_BLK_DEV_XD, CONFIG_BLK_DEV_PS2)
> 
> I am not certain how much this stuff is still used outside the US.  The XT
> driver still being around does surprise me though.  (Will that even *work*
> on modern hardware?  I didn't think you could get that card to work on a
> 386.)

Most of the boards work fine with 486. However, in most cases the BIOS
low-level-format routine does not work on them (timing issues). So low level
formatting needs a 386.
I think all of them should work on 586+ if without BIOS...

Andrzej
