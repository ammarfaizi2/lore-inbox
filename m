Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318061AbSIABGs>; Sat, 31 Aug 2002 21:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSIABGr>; Sat, 31 Aug 2002 21:06:47 -0400
Received: from ftp.mms.de ([193.103.160.42]:28166 "EHLO mms.de")
	by vger.kernel.org with ESMTP id <S318061AbSIABGr>;
	Sat, 31 Aug 2002 21:06:47 -0400
Date: Sun, 1 Sep 2002 03:11:08 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
Subject: 2.4.20-pre5-ac1: 80pin cable detection wrong?
Message-ID: <Pine.LNX.4.44.0209010303240.12765-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi...

Just installed kernel 2.4.20-pre5-ac1 and it seems to get the
cable-detection on my promise-controller wrong:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
[logs about the internal piix4 removed, this one works]
PDC20268: IDE controller at PCI slot 00:0f.0
PCI: Found IRQ 11 for device 00:0f.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xe7000000
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DJNA-352030, ATA DISK drive
hdc: WDC WD600AB-32CZA0, ATA DISK drive
hdd: ASUS CD-S400/A, ATAPI CD/DVD-ROM drive
hde: MAXTOR 4K080H4, ATA DISK drive
ULTRA 66/100/133: Primary channel of Ultra 66/100/133 requires an 80-pin
cable for Ultra66 operation.
         Switching to Ultra33 mode.
Warning: Primary channel requires an 80-pin cable for operation.
hde reduced to Ultra33 mode.
hdg: MAXTOR 4K080H4, ATA DISK drive
ULTRA 66/100/133: Secondary channel of Ultra 66/100/133 requires an 80-pin
cable for Ultra66 operation.
         Switching to Ultra33 mode.
Warning: Secondary channel requires an 80-pin cable for operation.
hdg reduced to Ultra33 mode.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xdc00-0xdc07,0xe002 on irq 11
ide3 at 0xe400-0xe407,0xe802 on irq 11
[...]
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63,
UDMA(100)
hdg: host protected area => 1
hdg: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63,
UDMA(100)

Both of the 80gb Maxtor-drives are connected to the promise pci-controller
with a 80pin-cable each.


c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

