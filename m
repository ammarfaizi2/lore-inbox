Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283513AbRK3Ffc>; Fri, 30 Nov 2001 00:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283512AbRK3FfW>; Fri, 30 Nov 2001 00:35:22 -0500
Received: from sdsl-216-36-113-151.dsl.sea.megapath.net ([216.36.113.151]:45530
	"EHLO stomata.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S283508AbRK3FfN>; Fri, 30 Nov 2001 00:35:13 -0500
Subject: drivers/block/block.o: In function `rd_blkdev_pagecache_IO' and
	`rd_make_request': undefined reference to `bio_size'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 29 Nov 2001 21:33:52 -0800
Message-Id: <1007098432.25394.2.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I haven't seen this mentioned on the list, yet.

drivers/block/block.o: In function `rd_blkdev_pagecache_IO':
drivers/block/block.o(.text+0x2884): undefined reference to `bio_size'
drivers/block/block.o: In function `rd_make_request':
drivers/block/block.o(.text+0x2a28): undefined reference to `bio_size'

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

CONFIG_MODULES=y
CONFIG_KMOD=y

CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y

CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDESCSI=m

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_IVB=y
CONFIG_BLK_DEV_IDE_MODES=y


