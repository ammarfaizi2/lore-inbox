Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbSJELCH>; Sat, 5 Oct 2002 07:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262299AbSJELCH>; Sat, 5 Oct 2002 07:02:07 -0400
Received: from tungsten.btinternet.com ([194.73.73.81]:31387 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S262295AbSJELCG>; Sat, 5 Oct 2002 07:02:06 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Kernel 2.5.40 DMA and mm issues
Date: Sat, 5 Oct 2002 12:07:39 +0100
User-Agent: KMail/1.4.7
Cc: Andrew Morton <akpm@digeo.com>, szonyi calin <caszonyi@yahoo.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210041555210.3823-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.44.0210041555210.3823-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210051207.39518.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 9:12 pm, Zwane Mwaikambo wrote:
> On Fri, 4 Oct 2002, Nick Sanders wrote:
> > I get the same 'DMA disabled' messages with 2.5 but DMA is never actually
> > disabled so I wouldn't rely on them being accurate (see below)
> >
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx VP_IDE: IDE controller at PCI slot 00:11.1
> > PCI: Hardcoded IRQ 14 for device 00:11.1
> > VP_IDE: chipset revision 6
> > VP_IDE: not 100% native mode: will probe irqs later
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on
> > pci00:11.1 ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
> > ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio hda: WDC
> > WD400BB-00CAA0, ATA DISK drive
> > hdb: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
> > hda: DMA disabled
> > hdb: DMA disabled
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > hdc: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
> > hdc: DMA disabled
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hda: host protected area => 1
> > hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
> > UDMA(100)
>
> IIRC not according to that line.
>

What line? All I meant was that the 'hda: DMA disabled' lines didn't actually 
disable DMA unless it's reenabled quietly somewhere later on. 

Nick

