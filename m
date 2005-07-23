Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVGWL7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVGWL7B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 07:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVGWL7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 07:59:01 -0400
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:63756 "EHLO
	smtp-vbr3.xs4all.nl") by vger.kernel.org with ESMTP id S261350AbVGWL67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 07:58:59 -0400
Date: Sat, 23 Jul 2005 13:58:48 +0200
From: Jurriaan on adsl-gate <thunder7@xs4all.nl>
To: mdew <some.nzguy@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HPT370 errors under 2.6.13-rc3-mm1
Message-ID: <20050723115848.GA30870@gates.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <1c1c863605072219283716a131@mail.gmail.com> <58cb370e0507221947c1b88a4@mail.gmail.com> <1c1c863605072304502cc25424@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1c863605072304502cc25424@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2005 at 11:50:43PM +1200, mdew wrote:
> looks like 2.6.12 does the same sort of thing..
> 
As a data-point, my dual HPT374 controllers are fine with
2.6.13-rc3-mm1. One onboard, one in a pci-slot in an Epox 4PCA3+ (socket
478, i875 chipset) motherboard.

Linux adsl-gate 2.6.13-rc3-mm1 #1 SMP Sat Jul 16 07:13:24 CEST 2005 i686 GNU/Linux

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 0000:02:00.0
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
HPT374: chipset revision 7
HPT374: 100% native mode on irq 16
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0x9400-0x9407, BIOS settings: hde:DMA, hdf:pio
HPT37X: using 33MHz PCI clock
    ide3: BM-DMA at 0x9408-0x940f, BIOS settings: hdg:DMA, hdh:pio
ACPI: PCI Interrupt 0000:02:00.1[A] -> GSI 16 (level, low) -> IRQ 16
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0x9900-0x9907, BIOS settings: hdi:DMA, hdj:pio
HPT37X: using 33MHz PCI clock
    ide5: BM-DMA at 0x9908-0x990f, BIOS settings: hdk:DMA, hdl:pio
Probing IDE interface ide2...
hde: WDC WD2000JB-00FUA0, ATA DISK drive
ide2 at 0x9000-0x9007,0x9102 on irq 16
Probing IDE interface ide3...
hdg: WDC WD2500JB-00FUA0, ATA DISK drive
ide3 at 0x9200-0x9207,0x9302 on irq 16
Probing IDE interface ide4...
hdi: WDC WD2000BB-00DAA1, ATA DISK drive
ide4 at 0x9500-0x9507,0x9602 on irq 16
Probing IDE interface ide5...
hdk: ST3300831A, ATA DISK drive
ide5 at 0x9700-0x9707,0x9802 on irq 16
HPT374: IDE controller at PCI slot 0000:02:05.0
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 21 (level, low) -> IRQ 21
HPT374: chipset revision 7
HPT374: 100% native mode on irq 21
HPT37X: using 33MHz PCI clock
    ide6: BM-DMA at 0x9f00-0x9f07, BIOS settings: hdm:pio, hdn:DMA
HPT37X: using 33MHz PCI clock
    ide7: BM-DMA at 0x9f08-0x9f0f, BIOS settings: hdo:pio, hdp:DMA
ACPI: PCI Interrupt 0000:02:05.1[A] -> GSI 21 (level, low) -> IRQ 21
HPT37X: using 33MHz PCI clock
    ide8: BM-DMA at 0xa400-0xa407, BIOS settings: hdq:DMA, hdr:pio
HPT37X: using 33MHz PCI clock
    ide9: BM-DMA at 0xa408-0xa40f, BIOS settings: hds:pio, hdt:DMA
Probing IDE interface ide6...
hdn: Maxtor 4A300J0, ATA DISK drive
ide6 at 0x9b00-0x9b07,0x9c02 on irq 21
Probing IDE interface ide7...
hdp: Maxtor 6Y200P0, ATA DISK drive
ide7 at 0x9d00-0x9d07,0x9e02 on irq 21
Probing IDE interface ide8...
hdq: WDC WD2500JB-00FUA0, ATA DISK drive
ide8 at 0xa000-0xa007,0xa102 on irq 21
Probing IDE interface ide9...
hdt: Maxtor 4A300J0, ATA DISK drive
ide9 at 0xa200-0xa207,0xa302 on irq 21
hda: max request size: 1024KiB
hda: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
hdc: max request size: 1024KiB
hdc: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2
hde: max request size: 1024KiB
hde: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(33)
hde: cache flushes supported
 hde: hde1
hdg: max request size: 1024KiB
hdg: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hdg: cache flushes supported
 hdg: hdg1
hdi: max request size: 1024KiB
hdi: 390721968 sectors (200049 MB) w/2048KiB Cache, CHS=24321/255/63, UDMA(100)
hdi: cache flushes supported
 hdi: hdi1
hdk: max request size: 1024KiB
hdk: 586072368 sectors (300069 MB) w/8192KiB Cache, CHS=36481/255/63, UDMA(100)
hdk: cache flushes supported
 hdk: hdk1
hdn: max request size: 1024KiB
hdn: 585940320 sectors (300001 MB) w/2048KiB Cache, CHS=36473/255/63, UDMA(100)
hdn: cache flushes supported
 hdn: hdn1
hdp: max request size: 1024KiB
hdp: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
hdp: cache flushes supported
 hdp: hdp1
hdq: max request size: 1024KiB
hdq: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hdq: cache flushes supported
 hdq: hdq1
hdt: max request size: 1024KiB
hdt: 585940320 sectors (300001 MB) w/2048KiB Cache, CHS=36473/255/63, UDMA(100)
hdt: cache flushes supported
 hdt: hdt1

Kind regards,
Jurriaan
