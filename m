Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132378AbRAEV40>; Fri, 5 Jan 2001 16:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRAEV4G>; Fri, 5 Jan 2001 16:56:06 -0500
Received: from mercury.eng.emc.com ([168.159.40.77]:57348 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S129267AbRAEVzz>; Fri, 5 Jan 2001 16:55:55 -0500
Message-ID: <276737EB1EC5D311AB950090273BEFDD979E4E@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Andre Hedrick'" <andre@linux-ide.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: boot up problem of IDE disk in 2.4.0!
Date: Fri, 5 Jan 2001 16:46:41 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried make config, the generated .config file
is the same as before. Will it bring any difference if
I compile again?

Thanks!

Xiangping

-----Original Message-----
From: Andre Hedrick [mailto:andre@linux-ide.org]
Sent: Friday, January 05, 2001 4:35 PM
To: chen, xiangping
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: boot up problem of IDE disk in 2.4.0!



Maybe run make config and not make oldconfig.


On Fri, 5 Jan 2001, chen, xiangping wrote:

> Hi, folks
> 
> I meet some problem when I tried by install kernel 2.4.0
> to a PC using IDE disk. It reports VFS panic error during
> boot up time when it tried to mount the rootfs. The error
> indicates that it can not find the driver for the harddisk,
> but I already build in the IDE disk support. The hard disk
> is seagate ST310212A. The related content in .config file
> is as follows. I would like to know what else I need to do.
> 
> Thanks
> 
> 
> 
> CONFIG_IDE=y
> # IDE, ATA and ATAPI Block devices
> CONFIG_BLK_DEV_IDE=y
> # Please see Documentation/ide.txt for help/info on IDE drives
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
> # CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
> # CONFIG_BLK_DEV_IDEDISK_IBM is not set
> # CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
> # CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
> # CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
> # CONFIG_BLK_DEV_IDEDISK_WD is not set
> # CONFIG_BLK_DEV_IDECS is not set
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDETAPE=m
> CONFIG_BLK_DEV_IDEFLOPPY=m
> CONFIG_BLK_DEV_IDESCSI=m
> # IDE chipset support/bugfixes
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_PCI_WIP=y
> CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
> # CONFIG_AMD7409_OVERRIDE is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> # Old CD-ROM drivers (not SCSI, not IDE)
> CONFIG_CD_NO_IDESCSI=y
> CONFIG_VIDEO_DEV=m
> # CONFIG_VIDEO_PROC_FS is not set
> CONFIG_VIDEO_BT848=m
> CONFIG_VIDEO_PMS=m
> CONFIG_VIDEO_BWQCAM=m
> CONFIG_VIDEO_CQCAM=m
> CONFIG_VIDEO_CPIA=m
> CONFIG_VIDEO_CPIA_PP=m
> CONFIG_VIDEO_CPIA_USB=m
> CONFIG_VIDEO_SAA5249=m
> # CONFIG_VIDEO_STRADIS is not set
> CONFIG_VIDEO_ZORAN=m
> CONFIG_VIDEO_BUZ=m
> # CONFIG_VIDEO_ZR36120 is not set
> CONFIG_VIDEO_SELECT=y
> CONFIG_SOUND_TRIDENT=m                    
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
