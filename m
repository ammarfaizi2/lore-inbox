Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbUKQRCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUKQRCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUKQRAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:00:07 -0500
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:3763 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S262405AbUKQQ6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:58:54 -0500
Date: Wed, 17 Nov 2004 19:58:51 +0300
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2 OOPS on boot with 3ware + reiserfs
Message-ID: <20041117165851.GA18044@tentacle.sectorb.msk.ru>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.6.9-rc2-mm1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nov 17 18:19:18 behemoth kernel: arq->state 2
Nov 17 18:19:18 behemoth kernel: Badness in as_requeue_request at drivers/block/as-iosched.c:1478
Nov 17 18:19:18 behemoth kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Nov 17 18:19:18 behemoth kernel:  [as_requeue_request+102/224] as_requeue_request+0x66/0xe0
Nov 17 18:19:18 behemoth kernel:  [elv_requeue_request+38/80] elv_requeue_request+0x26/0x50
Nov 17 18:19:18 behemoth kernel:  [blk_insert_request+171/176] blk_insert_request+0xab/0xb0
Nov 17 18:19:18 behemoth kernel:  [scsi_queue_insert+100/160] scsi_queue_insert+0x64/0xa0
Nov 17 18:19:18 behemoth kernel:  [scsi_softirq+164/192] scsi_softirq+0xa4/0xc0
Nov 17 18:19:18 behemoth kernel:  [__do_softirq+184/208] __do_softirq+0xb8/0xd0
Nov 17 18:19:18 behemoth kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Nov 17 18:19:18 behemoth kernel:  [do_IRQ+33/48] do_IRQ+0x21/0x30
Nov 17 18:19:18 behemoth kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
Nov 17 18:19:18 behemoth kernel:  [search_by_key+2122/4688] search_by_key+0x84a/0x1250
Nov 17 18:19:18 behemoth kernel:  [reiserfs_update_sd_size+159/512] reiserfs_update_sd_size+0x9f/0x200
Nov 17 18:19:18 behemoth kernel:  [reiserfs_dirty_inode+116/144] reiserfs_dirty_inode+0x74/0x90
Nov 17 18:19:18 behemoth kernel:  [reiserfs_submit_file_region_for_write+541/656] reiserfs_submit_file_region_for_write+0x21d/0x290
Nov 17 18:19:18 behemoth kernel:  [reiserfs_file_write+1453/1856] reiserfs_file_write+0x5ad/0x740
Nov 17 18:19:18 behemoth kernel:  [do_readv_writev+364/544] do_readv_writev+0x16c/0x220
Nov 17 18:19:18 behemoth kernel:  [vfs_writev+73/96] vfs_writev+0x49/0x60
Nov 17 18:19:18 behemoth kernel:  [sys_writev+65/112] sys_writev+0x41/0x70
Nov 17 18:19:18 behemoth kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

