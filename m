Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268970AbRHLHUP>; Sun, 12 Aug 2001 03:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268972AbRHLHUG>; Sun, 12 Aug 2001 03:20:06 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:2823 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268970AbRHLHT6>; Sun, 12 Aug 2001 03:19:58 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200108120721.JAA05389@green.mif.pg.gda.pl>
Subject: Re: PC keyboard unknown scancodes (Power, Sleep, Wake)
To: dwguest@win.tue.nl
Date: Sun, 12 Aug 2001 09:21:02 +0200 (CEST)
Cc: marekm@amelek.gda.pl, linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Aug 11, 2001 at 08:51:46PM +0200, Marek Michalkiewicz wrote:
> 
> > these three keys (on a cheap no-name "Designed for Win*" keyboard ;)
> > produce "unknown scancode" kernel messages when pressed or released.
> > 
> > Power - e0 5e
> > Sleep - e0 5f
> > Wake  - e0 63
> > 
> > I'd suggest adding support for them to linux/drivers/char/pc_keyb.c
> > but I'm not sure who maintains this file, so reporting this here...
> 
> You can use the setkeycodes command to tell the kernel about them.

It doesn't seem to fix the problem:

# dmesg -c
# setkeycodes e05f 127
# setkeycodes e05e 127
# dmesg -c
[ pressing some keys here ]
# dmesg -c
keyboard: unknown scancode e0 5e
keyboard: unknown scancode e0 5e
keyboard: unknown scancode e0 5f
keyboard: unknown scancode e0 5f

Am I doing something wrong ?

Andrzej



-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
