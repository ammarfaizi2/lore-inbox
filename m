Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283733AbRLISf7>; Sun, 9 Dec 2001 13:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283740AbRLISft>; Sun, 9 Dec 2001 13:35:49 -0500
Received: from mifgate.mif.pg.gda.pl ([153.19.42.120]:10702 "EHLO
	mifgate.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S283733AbRLISff>; Sun, 9 Dec 2001 13:35:35 -0500
Date: Sun, 9 Dec 2001 19:08:37 +0100 (CET)
From: Andrzej Krzysztofowicz <ankry@mifgate.mif.pg.gda.pl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: linux-2.5.1-pre7/drivers/block/xd.c compilation fix
 (version 2)
In-Reply-To: <Pine.LNX.4.33.0112082057540.9037-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112091849340.7194-100000@mifgate.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2001, Linus Torvalds wrote:
> On Sat, 8 Dec 2001, Adam J. Richter wrote:
> >
> > 	Linus, if nobody says otherwise, I recommend that you apply
> > this patch.
>
> Btw, do you actually _have_ a machine that uses the xd driver, or was this
> patch done just out of some perverse joy in theoretical retrocomputing?

I have somewhere a machine that used to work with such hardware, but
have never tested it with anything newer than 2.2.x kernel and have no
time to perform such tests in the near future (Maybe I'll find some after
Christmas).

AFAIR the hardware works fine with 386/486 with clock up to 66 MHz.
Faster machines have problems with BIOS initialization, probably due to
very slow EPROM chips or badly designed timing calculations in their
BIOSes. They *might* work with BIOS disabled/romoved, but all hardware I
have has the BIOS chips integrated.

Most hardwate supports drives up to 40 MB (I have only 20s) and the
transfer rates about 20-40 kB/s. Faster (with memory mapped I/O) boards
are not supported by the driver.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej

