Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSGMXov>; Sat, 13 Jul 2002 19:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSGMXou>; Sat, 13 Jul 2002 19:44:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17358 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315458AbSGMXou>; Sat, 13 Jul 2002 19:44:50 -0400
Date: Sun, 14 Jul 2002 01:47:16 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Adam J. Richter" <adam@freya.yggdrasil.com>
cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207132327.QAA08173@freya.yggdrasil.com>
Message-ID: <Pine.SOL.4.30.0207140138090.19631-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Jul 2002, Adam J. Richter wrote:

> On Sat, 13 Jul 2002, Bartlomiej Zolnierkiewicz wrote:
> >On Sat, 13 Jul 2002, Adam J. Richter wrote:
> [...]
> >> 	Are there some non-ATAPI IDE CDROM's that
> >> linux-2.5.25/drivers/ide/ide-cdrom.c supports?   I was under
> >> the impression that ide-cdrom.c operated only through ATAPI.
>
> >Wrong impression. ;)
> >Hint: look for STANDARD_ATAPI macro usage.
>
> 	It looks like that macro should be renamed to something like
> STANDARD_MMC.  Everything that that macro controls still appears to
> go through ATA Packet Interface encapsulation.  Those quirks look like

Please verify against sff8020.

> they would likely be duplicated in a SCSI version of the same drives
> anyhow.  It should be easy to have sr_mod accomodate those drives.

I can't find them, there are some in sr_vendor.c but they are diffirent
issues.

>
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."

