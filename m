Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTLAOkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 09:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTLAOkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 09:40:45 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38142 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263513AbTLAOkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 09:40:43 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: mikpolniak <mikpolniak@adelphia.net>
Subject: Re: vt8235 ide0: Speed warnings UDMA 3/4/5 is not functional
Date: Mon, 1 Dec 2003 15:42:07 +0100
User-Agent: KMail/1.5.4
References: <pan.2003.12.01.14.12.20.713784@adelphia.net>
In-Reply-To: <pan.2003.12.01.14.12.20.713784@adelphia.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312011542.07130.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you use 80-wires cable?
If yes, please send full dmesg and output of 'hdparm -I /dev/hda'.

--bart

On Monday 01 of December 2003 15:12, mikpolniak wrote:
> I have a new Shuttle MK40VN motherboard with VIA KM400 and VT8235. I have
> tried kernel 2.6.0-test11 and 2.4.23 and only can get UDMA2 working on my
> hard drive.
>
> If i try hdparm -X69 -d 1 /dev/hda i get the speed warnings:
>
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 p12
> > ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX
> as device
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> Linux video capture interface: v1.00
> ide0: Speed warnings UDMA 3/4/5 is not functional.
> ide0: Speed warnings UDMA 3/4/5 is not functional.
> ide0: Speed warnings UDMA 3/4/5 is not functional.

