Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130807AbRAKUYi>; Thu, 11 Jan 2001 15:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbRAKUY3>; Thu, 11 Jan 2001 15:24:29 -0500
Received: from zeus.kernel.org ([209.10.41.242]:60635 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130807AbRAKUYT>;
	Thu, 11 Jan 2001 15:24:19 -0500
Date: Thu, 11 Jan 2001 20:31:58 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@neptun.fachschaften.tu-muenchen.de>
To: Tobias Ringstrom <tori@tellus.mine.nu>
cc: <andre@linux-ide.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA problem in 2.4.0
In-Reply-To: <Pine.LNX.4.30.0101111640120.5788-100000@svea.tellus>
Message-ID: <Pine.NEB.4.31.0101112024250.9238-100000@neptun.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Tobias Ringstrom wrote:

> When copying huge files from one disk to another (hda->hdc), I get the
> following error (after some hundred megabytes):
>
> hdc: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hdc: irq timeout: status=0xd1 { Busy }
> hdc: DMA disabled
> ide1: reset: success
>...
> VP_IDE: VIA vt82c596b IDE UDMA66 controller on pci0:7.1
>...
> Did I miss anything?

Could you try if the (experimental) version 3.11 of the VIA IDE driver
(announced by Vojtech Pavlik in [1]) fixes your problem? Simply copy the
two files you find there to drivers/ide after you unpacked the kernel
source.

> /Tobias

cu,
Adrian

[1] http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-02/0737.html


-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
