Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285738AbRLTB0r>; Wed, 19 Dec 2001 20:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbRLTB0g>; Wed, 19 Dec 2001 20:26:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19961 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S285738AbRLTB0V>; Wed, 19 Dec 2001 20:26:21 -0500
Date: Wed, 19 Dec 2001 20:25:49 -0500
From: Jean-Francois Levesque <jfl@jfworld.net>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDMA problem with Maxtor 7200rpm disk
Message-Id: <20011219202549.4b5ebada.jfl@jfworld.net>
In-Reply-To: <3C21350F.64374FA4@bigfoot.com>
In-Reply-To: <20011219151636.50e930ac.jfl@jfworld.net>
	<3C21350F.64374FA4@bigfoot.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I removed the audio card from my system, but no success, nothing changed.

I also tried another video card, same thing.

I removed my CD-ROM and disabled ide1 (secondary IDE), same thing...

Any ideas?

When I try to enable DMA with hdparm -d1 /dev/hda :

ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: DMA disabled
ide0: reset: success


(exact same error as while booting).

Do you have any floppy bootable program to test HD speed?

Thanks for your help,

Jean-François


On Wed, 19 Dec 2001 16:47:11 -0800
Tim Moore <timothymoore@bigfoot.com> wrote:
> 
> [dmesg output clipped]
> 
> 1. Remove the AudioPCI card, recheck.
> 2. Check jumpers on CD, s/b set to Master.
> 
> AudioPCI and some VIA chipsets don't play well together.
> 
> rgds,
> tim.
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
