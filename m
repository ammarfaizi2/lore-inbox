Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbSLXTIx>; Tue, 24 Dec 2002 14:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSLXTIx>; Tue, 24 Dec 2002 14:08:53 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:19923 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265773AbSLXTIw>; Tue, 24 Dec 2002 14:08:52 -0500
Date: Tue, 24 Dec 2002 14:10:39 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.53 : drivers/mtd/devices/blkmtd.c
Message-ID: <Pine.LNX.4.44.0212241408360.11827-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While 'make modules', I received the following error.
Regards,
Frank

drivers/mtd/devices/blkmtd.c:52:25: linux/iobuf.h: No such file or directory
drivers/mtd/devices/blkmtd.c: In function `blkmtd_readpage':
drivers/mtd/devices/blkmtd.c:218: warning: implicit declaration of function `alloc_kiovec'
drivers/mtd/devices/blkmtd.c:235: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:238: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:239: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:240: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:241: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:242: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:264: warning: implicit declaration of function `brw_kiovec'
drivers/mtd/devices/blkmtd.c:266: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:267: warning: implicit declaration of function `free_kiovec'
drivers/mtd/devices/blkmtd.c:168: warning: `blocks' might be used uninitialized in this function
drivers/mtd/devices/blkmtd.c: In function `write_queue_task':
drivers/mtd/devices/blkmtd.c:327: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:355: `KIO_MAX_SECTORS' undeclared (first use in this function)
drivers/mtd/devices/blkmtd.c:355: (Each undeclared identifier is reported only once
drivers/mtd/devices/blkmtd.c:355: for each function it appears in.)
drivers/mtd/devices/blkmtd.c:373: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:374: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:386: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:388: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:396: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:397: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:411: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:302: warning: `blocks' might be used uninitialized in this function
make[3]: *** [drivers/mtd/devices/blkmtd.o] Error 1
make[2]: *** [drivers/mtd/devices] Error 2
make[1]: *** [drivers/mtd] Error 2
make: *** [drivers] Error 2
 

