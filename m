Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSHZRfr>; Mon, 26 Aug 2002 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318161AbSHZRfr>; Mon, 26 Aug 2002 13:35:47 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53259
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318159AbSHZRfq>; Mon, 26 Aug 2002 13:35:46 -0400
Date: Mon, 26 Aug 2002 10:38:33 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ATA err with 2.4.20-ac1
In-Reply-To: <20020826103525.7817bb4e.Gregor.Fajdiga@telemach.net>
Message-ID: <Pine.LNX.4.10.10208261038100.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No biggie, the driver just barfed the command and all is cool.

On Mon, 26 Aug 2002, Grega Fajdiga wrote:

> Good day,
> 
> I get these errors with 2.4.20-ac1:
> 
> hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: task_no_data_intr: error=0x04 { DriveStatusError }
> 
> Relevant part of the config
> 
> # CONFIG_PARIDE is not set
> # ATA/IDE/MFM/RLL support
> CONFIG_IDE=y
> # IDE, ATA and ATAPI Block devices
> CONFIG_BLK_DEV_IDE=y
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> # CONFIG_IDEDISK_STROKE is not set
> # CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
> # CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
> # CONFIG_BLK_DEV_IDEDISK_IBM is not set
> # CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
> # CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
> # CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
> # CONFIG_BLK_DEV_IDEDISK_WD is not set
> # CONFIG_BLK_DEV_IDECS is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDECD_BAILOUT is not set
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> CONFIG_IDE_TASK_IOCTL=y
> CONFIG_IDE_TASKFILE_IO=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_PCI_WIP is not set
> # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> # CONFIG_AMD74XX_OVERRIDE is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> If there is anything else I can provide, please tell.
> 
> Regards,
> Grega
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

