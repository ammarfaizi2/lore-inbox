Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271609AbRIBKmC>; Sun, 2 Sep 2001 06:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271610AbRIBKlu>; Sun, 2 Sep 2001 06:41:50 -0400
Received: from ap.popik.pl ([212.14.18.218]:38019 "EHLO ap.popik.pl")
	by vger.kernel.org with ESMTP id <S271609AbRIBKld>;
	Sun, 2 Sep 2001 06:41:33 -0400
Date: Sun, 2 Sep 2001 12:41:50 +0200 (CEST)
From: Adam Popik <popik@ap.popik.pl>
X-X-Sender: <popik@ap.popik.pl>
To: <linux-kernel@vger.kernel.org>
Subject: VMware and kernel 2.4.7,8,9
Message-ID: <Pine.LNX.4.33.0109021239510.11190-100000@ap.popik.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What was changed in this kernels ? I cannot compile modules for vmware.
errors:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/pagemap.h:16,
                 from /usr/src/linux/include/linux/locks.h:8,
                 from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
                 from /usr/src/linux/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/usr/src/linux/include/asm/pgalloc.h:56: `PAGE_OFFSET' undeclared (first
use in
/usr/src/linux/include/asm/pgalloc.h:56: (Each undeclared identifier is
reported/usr/src/linux/include/asm/pgalloc.h:56: for each function it
appears in.)
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:103: `PAGE_SIZE' undeclared (first
use in t/usr/src/linux/include/linux/highmem.h: In function
`clear_user_highpage':
In file included from /usr/src/linux/include/linux/pagemap.h:16,
                 from /usr/src/linux/include/linux/locks.h:8,
                 from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
                 from /usr/src/linux/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/usr/src/linux/include/linux/highmem.h:48: `PAGE_SIZE' undeclared (first
use in
/usr/src/linux/include/linux/highmem.h: In function `clear_highpage':
/usr/src/linux/include/linux/highmem.h:54: `PAGE_SIZE' undeclared (first
use in
/usr/src/linux/include/linux/highmem.h: In function `memclear_highpage':
/usr/src/linux/include/linux/highmem.h:62: `PAGE_SIZE' undeclared (first
use in
/usr/src/linux/include/linux/highmem.h: In function
`memclear_highpage_flush':
/usr/src/linux/include/linux/highmem.h:76: `PAGE_SIZE' undeclared (first
use in
/usr/src/linux/include/linux/highmem.h: In function `copy_user_highpage':
In file included from /usr/src/linux/include/linux/pagemap.h:16,
                 from /usr/src/linux/include/linux/locks.h:8,
                 from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
                 from /usr/src/linux/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/usr/src/linux/include/linux/highmem.h:48: `PAGE_SIZE' undeclared (first
use in
/usr/src/linux/include/linux/highmem.h: In function `clear_highpage':
/usr/src/linux/include/linux/highmem.h:54: `PAGE_SIZE' undeclared (first
use in
/usr/src/linux/include/linux/highmem.h: In function `memclear_highpage':
/usr/src/linux/include/linux/highmem.h:62: `PAGE_SIZE' undeclared (first
use in
/usr/src/linux/include/linux/highmem.h: In function
`memclear_highpage_flush':
/usr/src/linux/include/linux/highmem.h:76: `PAGE_SIZE' undeclared (first
use in
/usr/src/linux/include/linux/highmem.h: In function `copy_user_highpage':
/usr/src/linux/include/linux/highmem.h:90: `PAGE_SIZE' undeclared (first
use in
/usr/src/linux/include/linux/highmem.h: In function `copy_highpage':
/usr/src/linux/include/linux/highmem.h:101: `PAGE_SIZE' undeclared (first
use in.././linux/driver.c: In function `LinuxDriver_Ioctl':
.././linux/driver.c:928: structure has no member named `dumpable'
make[1]: *** [driver.o] B³±d 1
make: *** [driver] B³±d 2

Adam


