Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285841AbRLTCo3>; Wed, 19 Dec 2001 21:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285835AbRLTCoT>; Wed, 19 Dec 2001 21:44:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13025 "EHLO
	VL-MS-MR001.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S285841AbRLTCoM>; Wed, 19 Dec 2001 21:44:12 -0500
Date: Wed, 19 Dec 2001 21:43:41 -0500
From: Jean-Francois Levesque <jfl@jfworld.net>
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA problem with Maxtor 7200rpm disk
Message-Id: <20011219214341.66b6b83e.jfl@jfworld.net>
In-Reply-To: <20011219203804.4c68f1ee.jfl@jfworld.net>
In-Reply-To: <20011219151636.50e930ac.jfl@jfworld.net>
	<w53k7viy91z.wl@megaela.fe.dis.titech.ac.jp>
	<20011219203804.4c68f1ee.jfl@jfworld.net>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the 2.4.17-rc2 kernel and I was able to boot. (but I'm not with 2.4.9, 2.4.12-ac5 and 2.4.16)

Unfortunately, when I try hdparm -d1 /dev/hda, I get the same errors 

hda: timeout waiting for DMA
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


What can influence the DMA on the BIOS else than the disk configuration?

I always get this PCI bus warning : 
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

Maybe I have somthing wrong with PCI bus that change everything???

Jean-François

PS: I have the lastest asus BIOS update (1003).
