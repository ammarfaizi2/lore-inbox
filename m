Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRCPSNJ>; Fri, 16 Mar 2001 13:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130824AbRCPSMt>; Fri, 16 Mar 2001 13:12:49 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:20232
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130820AbRCPSMp>; Fri, 16 Mar 2001 13:12:45 -0500
Date: Fri, 16 Mar 2001 10:11:54 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: kozkir-8 <kozkir-8@student.luth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: VIA686A chipset crash under 2.4.2-ac20
In-Reply-To: <1159080569.20010315172253@student.luth.se>
Message-ID: <Pine.LNX.4.10.10103161009390.14210-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, kozkir-8 wrote:

> 
> Kernel 2.4.2 with ac20 patch seems doesn't like my motherboard
> I have FIC SD11 with VIA686A chipset. I compiled it with support of
> VIA82Cxxx and DMA support by default. First it seemed like work but
> after a while I started to get errors like these:
> 
> kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

I am so tired of this report, I am about to hide these in a /dev/null
It is a nothing message.  And if the via-core is correct it will auto down
grade the trnasfer rate and you will not feel any effect.  Only a
marginally slow disk service.


> Before I compiled kernel 2.4.2 without ac patches and got the same errors.
> 
> HDD Fujitsu MPE3136AT.
> 
> Here is a part of config file for kernel (only set variables)
> 
> #
> # ATA/IDE/MFM/RLL support
> #
> CONFIG_IDE=y
> 
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=y
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_VIA82CXXX=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

