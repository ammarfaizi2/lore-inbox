Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273421AbRIWMiO>; Sun, 23 Sep 2001 08:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273438AbRIWMiE>; Sun, 23 Sep 2001 08:38:04 -0400
Received: from web10405.mail.yahoo.com ([216.136.130.97]:39429 "HELO
	web10405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273421AbRIWMhr>; Sun, 23 Sep 2001 08:37:47 -0400
Message-ID: <20010923123812.62399.qmail@web10405.mail.yahoo.com>
Date: Sun, 23 Sep 2001 22:38:12 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Preemptible 2.4.10-pre15 compile error
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Exactly, make modules error

make[2]: Entering directory
`/home/sk/src/linux/fs/adfs'
gcc -D__KERNEL__ -I/home/sk/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O3
-fomit-frame-pointer -fno-strict-aliasing -fno-common
-mcpu=i686 -march=i686 -fno-strength-reduce -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c
-o map.o map.c
map.c: In function `adfs_map_lookup':
map.c:271: `current' undeclared (first use in this
function)
map.c:271: (Each undeclared identifier is reported
only once
map.c:271: for each function it appears in.)
map.c:273: warning: implicit declaration of function
`preempt_schedule'
make[2]: *** [map.o] Error 1
make[2]: Leaving directory
`/home/sk/src/linux/fs/adfs'
make[1]: *** [_modsubdir_adfs] Error 2
make[1]: Leaving directory `/home/sk/src/linux/fs'
make: *** [_mod_fs] Error 2



=====
S.KIEU

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
