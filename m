Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282941AbRLKUUd>; Tue, 11 Dec 2001 15:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282824AbRLKUUY>; Tue, 11 Dec 2001 15:20:24 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:59399 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S282819AbRLKUUI>; Tue, 11 Dec 2001 15:20:08 -0500
Subject: 2.5.1-pre10:  Problems compiling ide-tape.c -- structure has no
	member named `b_reqnext' or `bh'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 11 Dec 2001 12:22:20 -0800
Message-Id: <1008102141.1397.0.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
ide-tape.o ide-tape.c
ide-tape.c: In function `idetape_input_buffers':
ide-tape.c:1512: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_output_buffers':
ide-tape.c:1538: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_update_buffers':
ide-tape.c:1565: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_abort_pipeline':
ide-tape.c:1709: warning: comparison between pointer and integer
ide-tape.c:1710: incompatible types in assignment
ide-tape.c:1711: warning: comparison between pointer and integer
ide-tape.c:1712: incompatible types in assignment
ide-tape.c: In function `idetape_active_next_stage':
ide-tape.c:1738: structure has no member named `bh'
ide-tape.c: In function `__idetape_kfree_stage':
ide-tape.c:1785: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_end_request':
ide-tape.c:1871: warning: comparison between pointer and integer
ide-tape.c:1911: warning: comparison between pointer and integer
ide-tape.c: In function `idetape_queue_pc_head':
ide-tape.c:1987: incompatible types in assignment
ide-tape.c: In function `idetape_create_read_cmd':
ide-tape.c:2540: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_create_read_buffer_cmd':
ide-tape.c:2572: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_create_write_cmd':
ide-tape.c:2589: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_do_request':
ide-tape.c:2621: warning: int format, pointer arg (arg 4)
ide-tape.c:2623: warning: long int format, int arg (arg 4)
ide-tape.c:2626: warning: comparison between pointer and integer
ide-tape.c:2626: warning: comparison between pointer and integer
ide-tape.c:2630: warning: int format, pointer arg (arg 3)
ide-tape.c:2664: warning: comparison between pointer and integer
ide-tape.c:2677: warning: comparison between pointer and integer
ide-tape.c:2677: warning: comparison between pointer and integer
ide-tape.c:2691: warning: comparison between pointer and integer
ide-tape.c:2696: warning: comparison between pointer and integer
ide-tape.c:2703: warning: int format, pointer arg (arg 2)
ide-tape.c:2721: warning: comparison between pointer and integer
ide-tape.c:2732: switch quantity not an integer
ide-tape.c:2747: structure has no member named `bh'
ide-tape.c:2764: structure has no member named `bh'
ide-tape.c:2769: structure has no member named `bh'
ide-tape.c:2772: incompatible types in assignment
ide-tape.c:2780: incompatible types in assignment
ide-tape.c:2785: incompatible types in assignment
ide-tape.c:2734: warning: unreachable code at beginning of switch
statement
ide-tape.c: In function `__idetape_kmalloc_stage':
ide-tape.c:2836: structure has no member named `b_reqnext'
ide-tape.c:2868: structure has no member named `b_reqnext'
ide-tape.c:2873: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_copy_stage_from_user':
ide-tape.c:2922: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_copy_stage_to_user':
ide-tape.c:2949: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_wait_for_request':
ide-tape.c:3080: warning: comparison between pointer and integer
ide-tape.c:3080: warning: comparison between pointer and integer
ide-tape.c: In function `__idetape_queue_pc_tail':
ide-tape.c:3188: incompatible types in assignment
ide-tape.c: In function `idetape_queue_rw_tail':
ide-tape.c:3450: structure has no member named `bh'
ide-tape.c:3451: incompatible types in assignment
ide-tape.c: In function `idetape_onstream_read_back_buffer':
ide-tape.c:3500: incompatible types in assignment
ide-tape.c: In function `idetape_verify_stage':
ide-tape.c:3658: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_add_chrdev_write_request':
ide-tape.c:3775: incompatible types in assignment
ide-tape.c: In function `idetape_empty_write_pipeline':
ide-tape.c:3863: structure has no member named `b_reqnext'
ide-tape.c:3866: structure has no member named `b_reqnext'
ide-tape.c:3878: structure has no member named `b_reqnext'
ide-tape.c:3846: warning: `bh' might be used uninitialized in this
function
ide-tape.c: In function `idetape_initiate_read':
ide-tape.c:3963: incompatible types in assignment
ide-tape.c: In function `idetape_pad_zeros':
ide-tape.c:4152: structure has no member named `b_reqnext'
make[2]: *** [ide-tape.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/ide'

