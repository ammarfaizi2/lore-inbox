Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268311AbSIRT0K>; Wed, 18 Sep 2002 15:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268330AbSIRT0K>; Wed, 18 Sep 2002 15:26:10 -0400
Received: from mout1.freenet.de ([194.97.50.132]:16589 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S268311AbSIRT0J>;
	Wed, 18 Sep 2002 15:26:09 -0400
Date: Wed, 18 Sep 2002 21:31:02 +0200
From: axel@hh59.org
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre7-ac1
Message-ID: <20020918193102.GA248@prester.hh59.org>
Mail-Followup-To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200209181703.g8IH3dk10674@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209181703.g8IH3dk10674@devserv.devel.redhat.com>
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!


I wanted to see whether I have those strange ide kernel boot messages I 
had in 2.5.36 in 2.4.20-pre7-ac1 as well, as you suggested me to check.

There is a compile error in piix.c:

make[4]: Entering directory /usr/src/linux-2.4.20-pre7-ac1/drivers/ide/pci'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-pre7-ac1/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -I../
-nostdinc -iwithprefix include -DKBUILD_BASENAME=piix  -c -o piix.o piix.c
piix.c: In function 	nit_chipset_piix':
piix.c:533: init_chipset_piix causes a section type conflict
/usr/src/linux-2.4.20-pre7-ac1/include/linux/ide.h: At top level:
piix.c:696: warning: `piix_remove_one' defined but not used
make[4]: *** [piix.o] Error 1



Best regards,
Axel Siebenwirth



gcc version 3.2.1 20020915 (prerelease)

CONFIG_HAZARD_READ=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y

CONFIG_BLK_DEV_PIIX=y
