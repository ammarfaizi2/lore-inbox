Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSHZIml>; Mon, 26 Aug 2002 04:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSHZImk>; Mon, 26 Aug 2002 04:42:40 -0400
Received: from isis.telemach.net ([213.143.65.10]:35595 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S315720AbSHZImk>;
	Mon, 26 Aug 2002 04:42:40 -0400
Date: Mon, 26 Aug 2002 10:35:25 +0200
From: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
To: linux-kernel@vger.kernel.org
Subject: ATA err with 2.4.20-ac1
Message-Id: <20020826103525.7817bb4e.Gregor.Fajdiga@telemach.net>
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

I get these errors with 2.4.20-ac1:

hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError }

Relevant part of the config

# CONFIG_PARIDE is not set
# ATA/IDE/MFM/RLL support
CONFIG_IDE=y
# IDE, ATA and ATAPI Block devices
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDECD_BAILOUT is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

If there is anything else I can provide, please tell.

Regards,
Grega
