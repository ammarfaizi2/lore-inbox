Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSEaMgB>; Fri, 31 May 2002 08:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315227AbSEaMgA>; Fri, 31 May 2002 08:36:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2692 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315214AbSEaMf7>; Fri, 31 May 2002 08:35:59 -0400
Date: Fri, 31 May 2002 14:35:48 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <linux-kernel@vger.kernel.org>
cc: Roberto Nibali <ratz@drugphish.ch>, <dalecki@evision-ventures.com>
Subject: [ANNOUNCE] atapci 0.51
Message-ID: <Pine.SOL.4.30.0205311435020.25411-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 May 2002, Roberto Nibali wrote:

> Hello,
>
> > user-space tool to get info from ATA pci chipsets
> > (rewritten ide-info)
> > has all functionality of latest 2.5.x/2.4.x plus
> > - getting info from multiple identical cards
> > - simulation of ATA timings with changed PCI bus speed
>
> I don't know, either I'm too dumb to use it or there is still quite some
> code missing.

Ok, by mistake I made it 2.5.19 dependant (to compile), it is fixed now.
I've just copied pci_ids.h and errno-base.h from kernel to atapci/ dir.

So 0.51 version is here:
http://home.elka.pw.edu.pl/~bzolnier/atapci/atapci-0.51.tar.bz2

changelog:
- make it kernel version independent
- add '-s' strip flag to CFLAGS
- minor cosmetics by Roberto Nibali

--
bkz



