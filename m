Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285056AbRLSLZb>; Wed, 19 Dec 2001 06:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285188AbRLSLZV>; Wed, 19 Dec 2001 06:25:21 -0500
Received: from bs1.dnx.de ([213.252.143.130]:47505 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S285056AbRLSLZN>;
	Wed, 19 Dec 2001 06:25:13 -0500
Date: Wed, 19 Dec 2001 12:25:05 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.15 and 16 broken on AMD Elan
Message-ID: <Pine.LNX.4.33.0112191217160.1006-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The recent kernels seem to have a problem with AMDs Elan SC410 processor,
which basically is an 386 core. After starting the kernel the system
simply reboots; snapshot of boot process as following:

----------8<----------
Linux version 2.4.15-greased-turkey (robert@callisto) (gcc version 2.95.3
20010315 (SuSE)) #1 Wed Dec 19 09:22:28 CET 2001
BIOS-provided physical RAM map:
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 0000000000800000 (usable)
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=DNPX ro BOOT_FILE=/tmp/image/bzImage
console=ttyS0,115200 ip=bootp root=/dev/nfs
Initializing CPU#0
Calibrating delay loop... 16.53 BogoMIPS
Memory: 6428k/8192k available (805k kernel code, 1376k reserved, 184k
data, 60k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: AMD 02/0a stepping 04
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5
---------->8----------

At this moment the machine reboots. Same with 2.4.16; 2.4.14 and earlier
kernels worked without any problem.

Ideas?

Please send answers with Cc: as I'm not subscribed to the list.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

