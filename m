Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131496AbRCSQPH>; Mon, 19 Mar 2001 11:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRCSQO6>; Mon, 19 Mar 2001 11:14:58 -0500
Received: from ns.netlink.ru ([195.133.93.2]:23312 "EHLO ns.netlink.ru")
	by vger.kernel.org with ESMTP id <S131496AbRCSQOo> convert rfc822-to-8bit;
	Mon, 19 Mar 2001 11:14:44 -0500
Message-ID: <005701c0b090$5c4e7a00$5d5d85c3@netlink.ru>
From: "Alexander Sokolov" <robocop@netlink.ru>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with ZIP drive in 2.4.2-ac20
Date: Mon, 19 Mar 2001 19:19:23 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just installed a ZIP drive, and got the following error when booting the kernel:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC28400R, ATA DISK drive
hdc: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63, UDMA(33)
hdc: 98288kB, 196576 blocks, 512 sector size,  
hdc: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
ide-floppy: hdc: I/O error, pc = 5a, key =  5, asc = 24, ascq =  0

This annoying error appears each time I try to mount ZIP drive or eject it.
Despite this error, the drive works fine...

--
Alexander Sokolov
System Administrator
Netlink Co. Ltd.
Moscow, Russia



