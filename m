Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319249AbSHUXqN>; Wed, 21 Aug 2002 19:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319250AbSHUXqN>; Wed, 21 Aug 2002 19:46:13 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24327
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319249AbSHUXqM>; Wed, 21 Aug 2002 19:46:12 -0400
Date: Wed, 21 Aug 2002 16:49:37 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac6
In-Reply-To: <20020821234411.GA26772@codepoet.org>
Message-ID: <Pine.LNX.4.10.10208211648300.10353-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erik,

I am working on the logic changes in the separtation of code.
It is very likely I got some thing backwards but it is easy to test.

Cheers,

On Wed, 21 Aug 2002, Erik Andersen wrote:

> On Wed Aug 21, 2002 at 04:25:39PM -0400, Alan Cox wrote:
> > IDE status
> > 	Chasing two reports of strange ide-scsi crashes
> > 	Still some Promise glitches - need to review merge carefully
> 
> Its doesn't understand that I indeed am using 80 pin cables for
> the drives connected to my Promise 20267 controller.  Also, it would
> be nice to clean up the formatting on the "80-pin cable" message to
> keep it from wrapping.
> 
> 
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PDC20267: IDE controller on PCI bus 00 dev 58
> PDC20267: chipset revision 2
> PDC20267: not 100% native mode: will probe irqs later
> PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
>     ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:DMA
>     ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:DMA, hdh:pio
> [-------snip-------]
> hde: IC35L040AVER07-0, ATA DISK drive
> ULTRA 66/100/133: Primary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66
> operation.
>          Switching to Ultra33 mode.
> Warning: Primary channel requires an 80-pin cable for operation.
> hde reduced to Ultra33 mode.
> hdg: WDC WD1200BB-00CAA1, ATA DISK drive
> ULTRA 66/100/133: Secondary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66
> operation.
>          Switching to Ultra33 mode.
> Warning: Secondary channel requires an 80-pin cable for operation.
> hdg reduced to Ultra33 mode.
> [-------snip-------]
> hde: host protected area => 1
> hde: setmax LBA 80418240, native  1992187
> hde: 1992187 sectors (1020 MB) w/1916KiB Cache, CHS=1976/16/63, UDMA(33)
> hdg: host protected area => 1
> hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(33)
> 
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

