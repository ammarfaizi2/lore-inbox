Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269927AbRHMXeL>; Mon, 13 Aug 2001 19:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269928AbRHMXeB>; Mon, 13 Aug 2001 19:34:01 -0400
Received: from smtp2.netc.pt ([212.18.160.142]:15490 "EHLO smtp2.netc.pt")
	by vger.kernel.org with ESMTP id <S269927AbRHMXd5>;
	Mon, 13 Aug 2001 19:33:57 -0400
Date: Tue, 14 Aug 2001 01:31:28 +0100
From: Paulo Andre <baggio@netc.pt>
Subject: 2.4.8-ac3 fails on compiling
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Message-id: <01081401312801.01021@nirvana.local.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Got this compiling error when trying to build 2.4.8-ac3 on top of 2.4.8, it 
chokes when trying to compile the FAT support. Might aswell be a problem 
within the Makefile. Here's the produced output...


make -C fat
make[2]: Entering directory `/usr/src/linux/fs/fat'
make all_targets
make[3]: Entering directory `/usr/src/linux/fs/fat'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o buffer.o buffer.c
make[3]: *** No rule to make target `msbuffer.h', needed by `cache.o'.  Stop.
make[3]: Leaving directory `/usr/src/linux/fs/fat'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/fs/fat'
make[1]: *** [_subdir_fat] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [_dir_fs] Error 2


Cheers,

// Paulo Andre'
