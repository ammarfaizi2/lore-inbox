Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSGWMge>; Tue, 23 Jul 2002 08:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSGWMge>; Tue, 23 Jul 2002 08:36:34 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:51378 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S318031AbSGWMgc>;
	Tue, 23 Jul 2002 08:36:32 -0400
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Brad Hards <bhards@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.27 IDE: problems, again.
References: <20020722144557.GJ26837@tahoe.alcove-fr>
	<200207231120.00126.bhards@bigpond.net.au>
	<20020723095953.GB30505@tahoe.alcove-fr>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 23 Jul 2002 14:38:50 +0200
In-Reply-To: <20020723095953.GB30505@tahoe.alcove-fr>
Message-ID: <m3k7nmei05.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian.pop@fr.alcove.com> writes:

> On Tue, Jul 23, 2002 at 11:19:59AM +1000, Brad Hards wrote:
> 
> > > Right now I'm trying to recover my disk partition...
> > 
> > You are *out of your fscking mind*.
> 
> I do have some taste for the risk yes. However, until now I haven't 
> had any problems with 2.5 kernels.
> 
> > Why are you running 2.5 on a machine that has anything worth
> > recovering on it? IDE or SCSI, no matter.
> 
> This is my laptop and I occasionnally use it to do kernel related
> development. However, since I use this laptop for disconnected
> work too (like reading mail etc).
> 
> I do have backups however, so the risk is rather limited.
> 

Just to add my two øre to this; I've ran 2.5.27-dj2 since it came out,
both with ide as modules and compiled in with no ill effects. For the
record here's the ide bits from the boot log:

ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
keyboard: Timeout - AT keyboard not present?(ed)
ATA: Intel Corp. 82801CAM IDE U100, PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Assigned IRQ 11 for device 00:1f.1
ATA: chipset rev.: 2
ATA: non-legacy mode: IRQ probe delayed
PIIX: Intel Corp. 82801CAM IDE U100 UDMA100 controller on pci00:1f.1
PCI: Setting latency timer of device 00:1f.1 to 64
    ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
PCI: Setting latency timer of device 00:1f.1 to 64
    ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4019GAX, DISK drive
hdc: SD-R2102, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 78140160 sectors, CHS=77520/16/63, UDMA(100)
 hda: [PTBL] [5168/240/63] hda1 hda2 hda3

mvh,
A

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
