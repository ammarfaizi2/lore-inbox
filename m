Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292883AbSCGGVB>; Thu, 7 Mar 2002 01:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293196AbSCGGUv>; Thu, 7 Mar 2002 01:20:51 -0500
Received: from h139n1fls24o900.telia.com ([213.66.143.139]:45790 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id <S292883AbSCGGUo>;
	Thu, 7 Mar 2002 01:20:44 -0500
Date: Thu, 7 Mar 2002 07:21:24 +0100
From: Voluspa <voluspa@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.6-pre3 Kernel panic: VFS: Unable to mount root fs on 03:02
Message-Id: <20020307072124.6365c8ac.voluspa@bigfoot.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All 2.5.5-pre1/2.5.5 and 2.5.6-pre1/2 have worked well, but this -pre3 won't boot.
Low end system: Pentium 166 &200, 64 meg mem. Same .config used. Ext2 fs. Root at hda2.

Screen transcript:

[invisible]
Intel Corp. 82371FB PIIX IDE [Triton I]: IDE controller on PCI slot 00:07.1
Intel Corp. 82371FB PIIX IDE [Triton I]: chipset revision 2
Intel Corp. 82371FB PIIX IDE [Triton I]: not 100% native mode: will probe irqs later
   ide0: BM-DMA at 0x3000-0x3007, BIOS settings: hda:pio, hdb:pio
   ide1: BM-DMA at 0x3008-0x300f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307015, ATA DISK drive
hdb: CD-ROM CDU4011, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c030740c, I/O limit 4095 MB (mask 0xffffffff)
hda: 30003120 sectors (15362 MB) w/1916 KiB Cache, CHS=29765/16/63, (U)DMA
hdb: ATAPI 40X CD-ROM drive, 120 kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [PTBL] [1867/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Cannot open root device "302" or 03:02
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 03:02

I don't want to polute lkml with unnecessary dumps of /proc or .config, so ask for specifics and I will comply.

Regards,
Mats Johannesson
Sweden
