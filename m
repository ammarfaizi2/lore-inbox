Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbSBCDXH>; Sat, 2 Feb 2002 22:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSBCDW5>; Sat, 2 Feb 2002 22:22:57 -0500
Received: from web14608.mail.yahoo.com ([216.136.224.88]:57616 "HELO
	web14608.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285093AbSBCDWs>; Sat, 2 Feb 2002 22:22:48 -0500
Message-ID: <20020203032247.61375.qmail@web14608.mail.yahoo.com>
Date: Sun, 3 Feb 2002 03:22:47 +0000 (GMT)
From: =?iso-8859-1?q?Kurt=20Johnson?= <gorydetailz@yahoo.co.uk>
Subject: cant compile 2.5.3-dj1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I cant seem to be able to compile 2.5.3-dj1, the build
dies with:

make[2]: Circular
/usr/local/src/linux-2.5/include/linux/qnx4_fs.h <-
/usr/local/src/linux-2.5/include/linux/fs.h dependency
dropped.
/usr/local/bin/gcc -D__KERNEL__
-I/usr/local/src/linux-2.5/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i586  
-DKBUILD_BASENAME=filesystems  -DEXPORT_SYMTAB -c
filesystems.c
filesystems.c:36: syntax error before `int'
make[2]: *** [filesystems.o] Error 1
make[2]: Leaving directory
`/usr/local/src/linux-2.5/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory
`/usr/local/src/linux-2.5/fs'
make: *** [_dir_fs] Error 2

Is this a known issue? If so, is there any patch? 

Regards,

/kj

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
