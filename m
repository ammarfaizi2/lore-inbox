Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbSK3Jwp>; Sat, 30 Nov 2002 04:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbSK3Jwp>; Sat, 30 Nov 2002 04:52:45 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:34064 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id <S267228AbSK3Jwp>;
	Sat, 30 Nov 2002 04:52:45 -0500
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: hda: task_no_data_intr
Organization: Who, me?
User-Agent: tin/1.5.16-20021120 ("Spiders") (UNIX) (Linux/2.4.20-gzp2 (i686))
Message-ID: <34e8.3de88c28.44a4f@gzp1.gzp.hu>
Date: Sat, 30 Nov 2002 10:00:08 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What mean this message at boot time?

hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }

2.4.20, Pentium 1, Intel HX chipset.

ide: Assuming 33MHz system bus speed for PIO modes; override
with idebus=xx
PIIX3: IDE controller at PCI slot 00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
hda: QUANTUM FIREBALL ST4.3A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 8418816 sectors (4310 MB) w/81KiB Cache, CHS=524/255/63

Tried with 3 different hard disks, and got the same message
every time. Seems like I'm also unable to make ext3 fs on
the disks.

