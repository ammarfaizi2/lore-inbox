Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSIHVUl>; Sun, 8 Sep 2002 17:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSIHVUl>; Sun, 8 Sep 2002 17:20:41 -0400
Received: from smtp.comcast.net ([24.153.64.2]:55152 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S314459AbSIHVUk>;
	Sun, 8 Sep 2002 17:20:40 -0400
Date: Sun, 08 Sep 2002 17:21:02 -0400
From: Adam Jaskiewicz <adamjaskie@yahoo.com>
Subject: Re: Western Digital hard drive and DMA
In-reply-to: <Pine.LNX.4.33.0209081714500.18967-100000@coffee.psychology.mcmaster.ca>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Reply-to: adamjaskie@yahoo.com
Message-id: <02090817210208.00459@aragorn>
MIME-version: 1.0
X-Mailer: KMail [version 1.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.33.0209081714500.18967-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> first, what controller is it plugged into, and which kernel are you
> running, and what are the ide-related boot messages?

Well, ATM its 2.4.17, but ive had the problem all through since 2.4.5, which 
was the first kernel installed on this machine. The chipset is Intel 440BX. 

These are the IDE boot messages:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD600AB-00BVA0, ATA DISK drive
hdb: WDC AC313600D, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
hdd: PCRW804, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63, UDMA(33)
hdb: 26712000 sectors (13677 MB) w/1966KiB Cache, CHS=1662/255/63, UDMA(33)
hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, UDMA(33)

hdd is running though ide-scsi, as it is a cd-rw. hda and hdb both have dma 
turned off later in the boot process by hdparm. Could it be that I wasnt 
using those 80 conductor cables, and was getting crosstalk? I guess i could 
buy some to test that theory out...

-- 
Adam Jaskiewicz
adamjaskie@yahoo.com
http://middlearth.d2g.com:31415
talk:  adam@middlearth.d2g.com
--
... But we've only fondled the surface of that subject.
		-- Virginia Masters
