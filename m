Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbTDDKo5 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 05:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTDDKo5 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 05:44:57 -0500
Received: from mail.explainerdc.com ([212.72.36.220]:60835 "EHLO
	mail.explainerdc.com") by vger.kernel.org with ESMTP
	id S263541AbTDDKog convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 05:44:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Promise TX4 100: neither IDE port enabled
Date: Fri, 4 Apr 2003 12:56:02 +0200
Message-ID: <73300040777B0F44B8CE29C87A0782E101FA9875@exchange.explainerdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Promise TX4 100: neither IDE port enabled
Thread-Index: AcL6ihkH70lwH9+eTYKDuXL0JFI6kAADN48g
From: "Jonathan Vardy" <jonathan@explainerdc.com>
To: "Jonathan Vardy" <jonathan@explainerdc.com>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I've rebooted using the orignal Red Hat kernel (2.4.20) and it
recongnizes the Promise card. Here are the details:

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
PDC20270: IDE controller at PCI slot 02:01.0
PDC20270: chipset revision 2
PDC20270: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x9040-0x9047, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9048-0x904f, BIOS settings: hdg:pio, hdh:pio
    ide4: BM-DMA at 0x90c0-0x90c7, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x90c8-0x90cf, BIOS settings: hdk:pio, hdl:pio
hda: Maxtor 2B020H1, ATA DISK drive
blk: queue c0453420, I/O limit 4095Mb (mask 0xffffffff)
hdc: WDC WD1200BB-00CAA1, ATA DISK drive
blk: queue c04538a0, I/O limit 4095Mb (mask 0xffffffff)
hde: WDC WD1200BB-60CJA1, ATA DISK drive
blk: queue c0453d20, I/O limit 4095Mb (mask 0xffffffff)
hdg: WDC WD1200BB-60CJA1, ATA DISK drive
blk: queue c04541a0, I/O limit 4095Mb (mask 0xffffffff)
hdi: WDC WD1200BB-60CJA1, ATA DISK drive
blk: queue c0454620, I/O limit 4095Mb (mask 0xffffffff)
hdk: WDC WD1200BB-60CJA1, ATA DISK drive
blk: queue c0454aa0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9000-0x9007,0x9012 on irq 19
ide3 at 0x9020-0x9027,0x9032 on irq 19
ide4 at 0x9080-0x9087,0x9092 on irq 19
ide5 at 0x90a0-0x90a7,0x90b2 on irq 19
hda: host protected area => 1
hda: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63,
UDMA(33)
hdc: host protected area => 1
hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(33)
hde: host protected area => 1
hde: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(100)
hdg: host protected area => 1
hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(100)
hdi: host protected area => 1
hdi: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(100)
hdk: host protected area => 1
hdk: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(100)


Better results but doen anybody know why 2.4.21pre6 can't detect it
right?

> 
> ide: Assuming 33MHz system bus speed for PIO modes; override 
> with idebus=xx
> PIIX4: IDE controller at PCI slot 00:04.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
> PDC20270: IDE controller at PCI slot 02:01.0
> PDC20270: chipset revision 2
> PDC20270: not 100% native mode: will probe irqs later
> PDC20270: neither IDE port enabled (BIOS)
> PDC20270: neither IDE port enabled (BIOS)
> hda: Maxtor 2B020H1, ATA DISK drive
> blk: queue c0395860, I/O limit 4095Mb (mask 0xffffffff)
> hdc: WDC WD1200BB-00CAA1, ATA DISK drive
> blk: queue c0395cd0, I/O limit 4095Mb (mask 0xffffffff)
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: host protected area => 1
> hda: 39062500 sectors (20000 MB) w/2048KiB Cache, 
> CHS=2431/255/63, UDMA(33)
> hdc: host protected area => 1
> hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, 
> CHS=232581/16/63, UDMA(33)

