Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262345AbSJDUKL>; Fri, 4 Oct 2002 16:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262348AbSJDUKK>; Fri, 4 Oct 2002 16:10:10 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:61059
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262345AbSJDUIt>; Fri, 4 Oct 2002 16:08:49 -0400
Date: Fri, 4 Oct 2002 16:12:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Nick Sanders <sandersn@btinternet.com>
cc: Andrew Morton <akpm@digeo.com>, szonyi calin <caszonyi@yahoo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.5.40 DMA and mm issues
In-Reply-To: <200210040951.34071.sandersn@btinternet.com>
Message-ID: <Pine.LNX.4.44.0210041555210.3823-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002, Nick Sanders wrote:

> I get the same 'DMA disabled' messages with 2.5 but DMA is never actually 
> disabled so I wouldn't rely on them being accurate (see below)
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 00:11.1
> PCI: Hardcoded IRQ 14 for device 00:11.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
>     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
> hda: WDC WD400BB-00CAA0, ATA DISK drive
> hdb: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
> hda: DMA disabled
> hdb: DMA disabled
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
> hdc: DMA disabled
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: host protected area => 1
> hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)

IIRC not according to that line.

	Zwane
-- 
function.linuxpower.ca


