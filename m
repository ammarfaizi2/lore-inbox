Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbRFKS0c>; Mon, 11 Jun 2001 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262865AbRFKS0X>; Mon, 11 Jun 2001 14:26:23 -0400
Received: from clue4all.net ([66.92.68.202]:26887 "EHLO clue4all.net")
	by vger.kernel.org with ESMTP id <S262722AbRFKS0R>;
	Mon, 11 Jun 2001 14:26:17 -0400
Date: Mon, 11 Jun 2001 14:26:12 -0400 (EDT)
From: "Brian J. Conway" <dogbert@clue4all.net>
To: <linux-kernel@vger.kernel.org>
Subject: UDMA on Dell Inspiron 8000
Message-ID: <Pine.BSF.4.33.0106111421300.90812-100000@clue4all.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, I've been running Mandrake 8.0 on a new Dell Inspiron 8000 for
the past two weeks, and I was curious whether there's any reason that
autodma doesn't work for the IBM drive included with it, or whether it's
just a matter of not having a trusted/recognized IDE controller/drive
combination.  I'm running 2.4.6-pre2, and enabling DMA manually works
great and performance is improved drastically (of course).  Here's the
relevant portions of dmesg:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086,
DID=244a
PCI_IDE: chipset revision 3
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DJSA-210, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 19640880 sectors (10056 MB) w/384KiB Cache, CHS=1222/255/63
hdb: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4

If there's anything else that might be useful, please CC me in the email.

Brian J. Conway
dogbert@clue4all.net

