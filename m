Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbSJUUZP>; Mon, 21 Oct 2002 16:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSJUUZP>; Mon, 21 Oct 2002 16:25:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:946 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261614AbSJUUZO>;
	Mon, 21 Oct 2002 16:25:14 -0400
Message-Id: <200210212031.g9LKVKl18741@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.5.44 compile problem: MegaRAID driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Oct 2002 13:31:20 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 gcc -Wp,-MD,drivers/scsi/.megaraid.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=megaraid   -c -o drivers/scsi/megaraid.o 
drivers/scsi/megaraid.c
drivers/scsi/megaraid.c: In function `mega_cmd_done':
drivers/scsi/megaraid.c:1115: warning: passing arg 2 of `__constant_memcpy' 
makes pointer from integer without a cast
drivers/scsi/megaraid.c:1115: warning: passing arg 2 of `__memcpy' makes 
pointer from integer without a cast
drivers/scsi/megaraid.c: In function `mega_reorder_hosts':
drivers/scsi/megaraid.c:3514: `scsi_hostlist' undeclared (first use in this 
function)
drivers/scsi/megaraid.c:3514: (Each undeclared identifier is reported only once
drivers/scsi/megaraid.c:3514: for each function it appears in.)
drivers/scsi/megaraid.c:3514: structure has no member named `next'
drivers/scsi/megaraid.c:3488: warning: `shpnt' might be used uninitialized in 
this function
drivers/scsi/megaraid.c: In function `mega_swap_hosts':
drivers/scsi/megaraid.c:3558: structure has no member named `next'
drivers/scsi/megaraid.c:3560: `scsi_hostlist' undeclared (first use in this 
function)
drivers/scsi/megaraid.c:3560: structure has no member named `next'
.......repeated bunches
drivers/scsi/megaraid.c:3647: structure has no member named `next'
drivers/scsi/megaraid.c:3648: structure has no member named `next'
drivers/scsi/megaraid.c: In function `megadev_ioctl':
drivers/scsi/megaraid.c:4687: `scsi_hostlist' undeclared (first use in this 
function)
drivers/scsi/megaraid.c:4687: structure has no member named `next'
drivers/scsi/megaraid.c:4807: structure has no member named `next'
drivers/scsi/megaraid.c:4546: warning: `shpnt' might be used uninitialized in 
this function
make[2]: *** [drivers/scsi/megaraid.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

cliffw

