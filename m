Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283533AbRK3HaN>; Fri, 30 Nov 2001 02:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283536AbRK3HaE>; Fri, 30 Nov 2001 02:30:04 -0500
Received: from sdsl-216-36-113-151.dsl.sea.megapath.net ([216.36.113.151]:58334
	"EHLO stomata.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S283533AbRK3H3y>; Fri, 30 Nov 2001 02:29:54 -0500
Subject: 2.5.0-pre4 -- ide-tape.c:1512: structure has no member named
	`b_reqnext'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 29 Nov 2001 23:28:32 -0800
Message-Id: <1007105312.13812.6.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o ide-tape.o ide-tape.c
ide-tape.c: In function `idetape_input_buffers':
ide-tape.c:1512: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_output_buffers':
ide-tape.c:1538: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_update_buffers':
ide-tape.c:1565: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_active_next_stage':
ide-tape.c:1738: structure has no member named `bh'
ide-tape.c: In function `__idetape_kfree_stage':
ide-tape.c:1785: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_create_read_cmd':
ide-tape.c:2538: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_create_read_buffer_cmd':
ide-tape.c:2570: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_create_write_cmd':
ide-tape.c:2587: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_do_request':
ide-tape.c:2621: warning: long int format, int arg (arg 4)
ide-tape.c:2745: structure has no member named `bh'
ide-tape.c:2762: structure has no member named `bh'
ide-tape.c:2767: structure has no member named `bh'
ide-tape.c: In function `__idetape_kmalloc_stage':
ide-tape.c:2834: structure has no member named `b_reqnext'
ide-tape.c:2866: structure has no member named `b_reqnext'
ide-tape.c:2871: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_copy_stage_from_user':
ide-tape.c:2920: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_copy_stage_to_user':
ide-tape.c:2947: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_queue_rw_tail':
ide-tape.c:3448: structure has no member named `bh'
ide-tape.c: In function `idetape_verify_stage':
ide-tape.c:3656: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_empty_write_pipeline':
ide-tape.c:3861: structure has no member named `b_reqnext'
ide-tape.c:3864: structure has no member named `b_reqnext'
ide-tape.c:3876: structure has no member named `b_reqnext'
ide-tape.c:3844: warning: `bh' might be used uninitialized in this function
ide-tape.c: In function `idetape_pad_zeros':
ide-tape.c:4150: structure has no member named `b_reqnext'
make[2]: *** [ide-tape.o] Error 1

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y
#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
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

