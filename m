Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281966AbRLWVxk>; Sun, 23 Dec 2001 16:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282056AbRLWVxa>; Sun, 23 Dec 2001 16:53:30 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:19991 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S281966AbRLWVxX>; Sun, 23 Dec 2001 16:53:23 -0500
From: Andy Furniss <andy@furniss.freeserve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA problem with Maxtor 7200rpm disk
Date: Sun, 23 Dec 2001 21:53:11 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01122321531100.00783@MBC>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>When I try to enable DMA with hdparm -d1 /dev/hda :

>ide_dmaproc: chipset supported ide_dma_timeout func only: 14
>hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>hda: timeout waiting for DMA
>ide_dmaproc: chipset supported ide_dma_timeout func only: 14
>hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>hda: timeout waiting for DMA
>ide_dmaproc: chipset supported ide_dma_timeout func only: 14
>hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>hda: timeout waiting for DMA
>ide_dmaproc: chipset supported ide_dma_timeout func only: 14
>hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>hda: DMA disabled
>ide0: reset: success

I got this when I got my 40G 5200 maxtor. I've got an old award bios & PII 
with 440bx chipset.

The solution was to turn off udma in bios my 2.2 kernel and w98 could then 
use mdma.

I noticed that when I tested with a 2.4.9 it could use udma again - even 
though it remains off (for W98 & 2.2) in bios.

Andy.
