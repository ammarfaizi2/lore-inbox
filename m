Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131427AbRANIqf>; Sun, 14 Jan 2001 03:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131428AbRANIqZ>; Sun, 14 Jan 2001 03:46:25 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:24580 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S131427AbRANIqP>;
	Sun, 14 Jan 2001 03:46:15 -0500
Date: Sun, 14 Jan 2001 08:44:59 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Adrian Bunk <bunk@fs.tum.de>
cc: <andre@linux-ide.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: IDE DMA problem in 2.4.0
In-Reply-To: <Pine.LNX.4.30.0101120942170.7175-100000@svea.tellus>
Message-ID: <Pine.LNX.4.30.0101140843320.1590-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Tobias Ringstrom wrote:

> On Thu, 11 Jan 2001, Adrian Bunk wrote:
> > On Thu, 11 Jan 2001, Tobias Ringstrom wrote:
> >
> > > When copying huge files from one disk to another (hda->hdc), I get the
> > > following error (after some hundred megabytes):
> > >
> > > hdc: timeout waiting for DMA
> > > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> > > hdc: irq timeout: status=0xd1 { Busy }
> > > hdc: DMA disabled
> > > ide1: reset: success
> > >...
> > > VP_IDE: VIA vt82c596b IDE UDMA66 controller on pci0:7.1
> > >...
> > > Did I miss anything?
> >
> > Could you try if the (experimental) version 3.11 of the VIA IDE driver
> > (announced by Vojtech Pavlik in [1]) fixes your problem? Simply copy the
> > two files you find there to drivers/ide after you unpacked the kernel
> > source.
>
> Works like a charm!  I copied the full 4 GB without glitches, and it has
> not eaten my filesystem yet, either.  I will continue to stress it, and
> report any errors I find.

Hrmph...  Grrr...  No, I got the same error again, it was just soooo much
harder to get it.  The error is still there, I'm afraid.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
