Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135361AbRDLWLp>; Thu, 12 Apr 2001 18:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135362AbRDLWLg>; Thu, 12 Apr 2001 18:11:36 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.14]:32989 "EHLO
	continuum.localnet.cm.nu") by vger.kernel.org with ESMTP
	id <S135361AbRDLWLR>; Thu, 12 Apr 2001 18:11:17 -0400
Date: Thu, 12 Apr 2001 15:11:12 -0700
From: Shane Wegner <shane@cm.nu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.2.19.04092001.patch
Message-ID: <20010412151112.A17803@cm.nu>
In-Reply-To: <20010410223554.A938@cm.nu> <Pine.LNX.4.10.10104121505140.4564-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.10.10104121505140.4564-100000@master.linux-ide.org>; from andre@linux-ide.org on Thu, Apr 12, 2001 at 03:05:53PM -0700
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2001 at 03:05:53PM -0700, Andre Hedrick wrote:
> 
> So you want a VIA-old and VIA-new ??

Hi,

Is the version of the driver in the latest IDE patch v4.x? 
That's odd as that driver does work fine on Linux 2.4.3. 
It's just the one in 2.2.19+ide.2.2.19.0405 which seems to
be locking up.

Best regards,
Shane

> 
> On Tue, 10 Apr 2001, Shane Wegner wrote:
> 
> > On Mon, Apr 09, 2001 at 05:33:13PM -0700, Andre Hedrick wrote:
> > > 
> > > This is up with some updates
> > Hi,
> > 
> > This isn't working here on my Abit VP6 board.  The
> > ide.2.2.18.1221 works fine but this latest patch as well as
> > ide.2.2.19.0325 fails.
> > 
> > Uniform Multi-Platform E-IDE driver Revision: 6.30
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > VP_IDE: IDE controller on PCI bus 00 dev 39
> > VP_IDE: chipset revision 6
> > VP_IDE: not 100% native mode: will probe irqs later
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
> >     ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
> > HPT370: IDE controller on PCI bus 00 dev 70
> > HPT370: chipset revision 3
> > HPT370: not 100% native mode: will probe irqs later
> >     ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
> >     ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
> > hda: Maxtor 92720U8, ATA DISK drive
> > hdg: Maxtor 96147U8, ATA DISK drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide3 at 0xe400-0xe407,0xe802 on irq 10
> > 
> > That's where it stops.  Locks solid, not even sysrq-b
> > works.
> > 
> > Shane
> > 
> > -- 
> > Shane Wegner: shane@cm.nu
> >               http://www.cm.nu/~shane/
> > PGP:          1024D/FFE3035D
> >               A0ED DAC4 77EC D674 5487
> >               5B5C 4F89 9A4E FFE3 035D
> > 
> 
> Andre Hedrick
> Linux ATA Development
> ASL Kernel Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
