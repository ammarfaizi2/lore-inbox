Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSIALRx>; Sun, 1 Sep 2002 07:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSIALRx>; Sun, 1 Sep 2002 07:17:53 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:31955 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S316673AbSIALRw>; Sun, 1 Sep 2002 07:17:52 -0400
Subject: 2.5.33 -- drivers/built-in.o: In function
	`isd200_get_inquiry_data': undefined reference to `ata_fix_driveid'
From: Miles Lane <miles.lane@attbi.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1030877078.10475.2.camel@agate.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 01 Sep 2002 03:44:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/built-in.o: In function `isd200_get_inquiry_data':
drivers/built-in.o(.text+0xc0652): undefined reference to
`ata_fix_driveid'

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y


