Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130512AbRCDUgD>; Sun, 4 Mar 2001 15:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130516AbRCDUfy>; Sun, 4 Mar 2001 15:35:54 -0500
Received: from sunbeam.cs.biu.ac.il ([132.70.1.24]:64392 "EHLO
	sunbeam.cs.biu.ac.il") by vger.kernel.org with ESMTP
	id <S130512AbRCDUfk>; Sun, 4 Mar 2001 15:35:40 -0500
Date: Sun, 4 Mar 2001 22:33:50 +0200 (IST)
From: Yuval Krymolowski <yuvalk@macs.biu.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Can Linux 2.4.x boot from UDMA-100 disk ?
Message-ID: <Pine.LNX.4.21.0103042231110.1665-100000@yuval>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 I have a system with ABIT BX-133/RAID mother-board, and run
 Gentus Linux booted from /dev/hde, which is UDMA/100 IBM-DTLA-307030 drive.
 The following lines of the boot-log can provide information about
 the system (kernel version 2.2.15-3.0).

 Would it be possible to boot kernel 2.4.x from the UDMA/100 drive ?
 in http://www.linux-ide.org/ultra100.html it is not mentioned if
 the patches can help with boot.

  Thanks,
     Yuval Krymolowski, yuvalk@cs.biu.ac.il
     (I will check the list but please CC me as well).

 kernel: Uniform Multi-Platform E-IDE driver Revision: 6.30
 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 kernel: PIIX4: IDE controller on PCI bus 00 dev 39
 kernel: PIIX4: not 100% native mode: will probe irqs later
 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
 kernel: HPT370: IDE controller on PCI bus 00 dev 98
 kernel: HPT370: not 100% native mode: will probe irqs later
 kernel: HPT370: reg5ah=0x01 ATA-66 Cable Port0
 kernel:     ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
 kernel: HPT370: reg5ah=0x01 ATA-66 Cable Port0
 kernel:     ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:DMA, hdh:pio
 kernel: hda: FX4820T, ATAPI CDROM drive
 kernel: hdc: SAMSUNG COMBO SM-304B, ATAPI CDROM drive
 kernel: hde: IBM-DTLA-307030, ATA DISK drive
 kernel: hdg: WDC WD136AA, ATA DISK drive
 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 kernel: ide1 at 0x170-0x177,0x376 on irq 15
 kernel: ide2 at 0xd800-0xd807,0xdc02 on irq 11
 kernel: ide3 at 0xe000-0xe007,0xe402 on irq 11 (shared with ide2)
 kernel: hde: IBM-DTLA-307030, 29314MB w/1916kB Cache, CHS=3737/255/63, UDMA(100)
 kernel: hdg: WDC WD136AA, 12971MB w/2048kB Cache, CHS=1653/255/63, UDMA(33)
 kernel: hda: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
 kernel: md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
 kernel: raid5: measuring checksumming speed
 kernel: raid5: MMX detected, trying high-speed MMX checksum routines
 kernel:    pII_mmx   :  1777.746 MB/sec
 kernel:    p5_mmx    :  1836.039 MB/sec
 kernel:    8regs     :  1376.172 MB/sec
 kernel:    32regs    :   783.336 MB/sec
 kernel: using fastest function: p5_mmx (1836.039 MB/sec)

