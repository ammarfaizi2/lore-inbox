Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314557AbSEKEpe>; Sat, 11 May 2002 00:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314575AbSEKEpd>; Sat, 11 May 2002 00:45:33 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:16402 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S314557AbSEKEpc>;
	Sat, 11 May 2002 00:45:32 -0400
Date: Sat, 11 May 2002 00:36:40 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.15 : drivers/md/lvm.c compile error
Message-ID: <Pine.LNX.4.33.0205110033550.4235-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  I didn't see the following error posted yet, but if I has, sorry in 
advance.

Regards,
Frank

lvm.c:1:2: #error Broken until maintainers will sanitize kdev_t handling
lvm.c: In function `lvm_user_bmap':
lvm.c:1023: structure has no member named `bi_dev'
lvm.c:1024: structure has no member named `bi_dev'
lvm.c:1032: structure has no member named `bi_dev'
lvm.c:1032: structure has no member named `bi_dev'
lvm.c:1032: structure has no member named `bi_dev'
lvm.c:1032: structure has no member named `bi_dev'
lvm.c: In function `lvm_map':
lvm.c:1102: structure has no member named `bi_dev'
lvm.c:1226: structure has no member named `bi_dev'
lvm.c: In function `lvm_geninit':
lvm.c:2671: `blksize_size' undeclared (first use in this function)
lvm.c:2671: (Each undeclared identifier is reported only once
lvm.c:2671: for each function it appears in.)
make[2]: *** [lvm.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/md'
make[1]: *** [_modsubdir_md] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2


