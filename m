Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316912AbSE3XId>; Thu, 30 May 2002 19:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316916AbSE3XIc>; Thu, 30 May 2002 19:08:32 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:33033 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316912AbSE3XIc>;
	Thu, 30 May 2002 19:08:32 -0400
Date: Thu, 30 May 2002 18:59:10 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.19 : drivers/mtd/nftlcore.c compile error
Message-ID: <Pine.LNX.4.33.0205301856440.22084-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  I haven't the following error posted yet. While 'make modules', I 
received the following error:

nftlcore.c: In function `nftl_ioctl':
nftlcore.c:795: warning: implicit declaration of function `fsync_bdev_Rsmp_ad6305a4'
nftlcore.c:796: warning: implicit declaration of function `invalidate_bdev_Rsmp_72d550ae'
nftlcore.c: In function `nftl_request':
nftlcore.c:849: warning: passing arg 1 of `_raw_spin_unlock' from incompatible pointer type
nftlcore.c:852: warning: long unsigned int format, unsigned int arg (arg 4)
nftlcore.c:902: warning: comparison between pointer and integer
nftlcore.c:930: warning: passing arg 1 of `_raw_spin_lock' from incompatible pointer type
nftlcore.c: In function `init_nftl':
nftlcore.c:1031: too few arguments to function `blk_init_queue_Rsmp_b0d20f3a'
nftlcore.c:1021: warning: unused variable `i'
make[2]: *** [nftlcore.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/mtd'
make[1]: *** [_modsubdir_mtd] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

Regards,
Frank
A

