Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129975AbRAPEIY>; Mon, 15 Jan 2001 23:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbRAPEIP>; Mon, 15 Jan 2001 23:08:15 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:59405
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129975AbRAPEIA>; Mon, 15 Jan 2001 23:08:00 -0500
Date: Mon, 15 Jan 2001 20:07:31 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Tim Hockin <thockin@isunix.it.ilstu.edu>
cc: linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: IDE not fully found (2.4.0)
In-Reply-To: <200101160258.UAA04062@isunix.it.ilstu.edu>
Message-ID: <Pine.LNX.4.10.10101152006110.12696-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, Tim Hockin wrote:

> Just built a new system with Linux-2.4.0.
> 
> Motherboard (MSI 694D-AR) has Via Apollo Pro chipset, those IDE drives seem
> fine.  Board also has a promise PDC20265  RAID/ATA100 controller.  On each
> channel of this controller I have an IBM 45 GB ATA100 drive as master.
> (hde and hdg?).  BIOS sees these drives fine.  Linux only see hde and never
> hdg (ide[012] but not ide3).  I thought I'd post it here, in case anyone
> else knew the answer right away.  

Ask AE...B

> Second question:  Does the RAID functionality of this device work under
> linux?  If so, is it better than LVM or MD?

NO, frauds allowed (raid)


> boot snippet:
> ---------------
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 16
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
>     ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
> PDC20265: IDE controller on PCI bus 00 dev 60
> PDC20265: chipset revision 2
> PDC20265: not 100% native mode: will probe irqs later
> PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
> Mode.
>     ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
