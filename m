Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270283AbTHGQVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270324AbTHGQVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:21:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:18132 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270283AbTHGQVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:21:22 -0400
Date: Thu, 7 Aug 2003 18:20:46 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ian Chilton <ian@ichilton.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DMA problem with 2.4.21 and 2.4.22-rc1
In-Reply-To: <20030807160938.GC31296@roadrunner.ichilton.net>
Message-ID: <Pine.SOL.4.30.0308071819200.26811-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You don't have driver for you ide chipset compiled in.

--bartlomiej

On Thu, 7 Aug 2003, Ian Chilton wrote:

> Hello,
>
> [Please cc me in on any replies]
>
>
> I am having problems getting a box into DMA mode with 2.4.21 and
> 2.4.22-rc1:
>
> [root@baloo:~]# hdparm -d1 /dev/hda
>
> /dev/hda:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)
>
>
> Relevent dmesg stuff:
>
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> hda: C/H/S=19158/16/255 from BIOS ignored
> hda: WDC WD400JB-00ENA0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: attached ide-disk driver.
> hda: host protected area => 1
> hda: 78165360 sectors (40021 MB) w/8192KiB Cache, CHS=77545/16/63
>
>
> Any ideas?
>
>
> Thanks!
>
> --ian

