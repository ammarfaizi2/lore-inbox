Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTK0D7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 22:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264431AbTK0D7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 22:59:12 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:3492 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264430AbTK0D7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 22:59:10 -0500
Subject: 2.6.0-test10 hanging on drive detection
From: Harold Martin <cocoadev@earthlink.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1069905548.3479.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 26 Nov 2003 20:59:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I boot 2.6.0-test10, it hangs on this message:
hdd: ATAPI 40X DVD-ROM drive 512kB Cache, UDMA(33)

>From my .config:
grep -i ata .config
CONFIG_X86_MCE_NONFATAL=y
# ATA/ATAPI/MFM/RLL support
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_ATALK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_ATARI_PARTITION is not set

grep -i IDE .config
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
# Please see Documentation/ide.txt for help/info on IDE drives
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set
# IDE chipset support/bugfixes
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
CONFIG_IEEE1394_VIDEO1394=m
# CONFIG_VIDEO_DEV is not set
# Digital Video Broadcasting Devices
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_TRIDENT is not set
# CONFIG_SND_TRIDENT is not set
# Video4Linux support is needed for USB Multimedia device support

If there is any other information I can supply, please tell me.

Thanks,
Harold

