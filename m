Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTDDI7j (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 03:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTDDI7i (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 03:59:38 -0500
Received: from mail.explainerdc.com ([212.72.36.220]:48545 "EHLO
	mail.explainerdc.com") by vger.kernel.org with ESMTP
	id S263429AbTDDI71 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 03:59:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Promise TX4 100: neither IDE port enabled
Date: Fri, 4 Apr 2003 11:10:56 +0200
Message-ID: <73300040777B0F44B8CE29C87A0782E101FA982C@exchange.explainerdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Promise TX4 100: neither IDE port enabled
Thread-Index: AcL6ihkH70lwH9+eTYKDuXL0JFI6kA==
From: "Jonathan Vardy" <jonathan@explainerdc.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having trouble getting my promise fasttrak TX4 running with Red
Hat. I am using kerner 2.4.21-pre6 compiled with 

PROMISE PDC202{46|62|65|67} support
Special UDMA Feature
PROMISE PDC202{68|69|70|71|75|76|77} support

But without Special FastTrak Feature and Support for IDE Raid
controllers (EXPERIMENTAL)

While booting I get the following results:

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
PDC20270: neither IDE port enabled (BIOS)
PDC20270: neither IDE port enabled (BIOS)
hda: Maxtor 2B020H1, ATA DISK drive
blk: queue c0395860, I/O limit 4095Mb (mask 0xffffffff)
hdc: WDC WD1200BB-00CAA1, ATA DISK drive
blk: queue c0395cd0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63,
UDMA(33)
hdc: host protected area => 1
hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(33)

As you can see the Promise card is not functioning at all. Doen anyone
have any ideas why it is not functioning?

Thanks, Jonathan Vardy
