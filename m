Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278633AbRJ1S1p>; Sun, 28 Oct 2001 13:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278648AbRJ1S1f>; Sun, 28 Oct 2001 13:27:35 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:11926 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S278633AbRJ1S1W>; Sun, 28 Oct 2001 13:27:22 -0500
Date: Sun, 28 Oct 2001 19:15:54 +0100 (CET)
From: kees <kees@schoen.nl>
To: <linux-kernel@vger.kernel.org>
Subject: report build problem
Message-ID: <Pine.LNX.4.33.0110281913510.30563-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-2.4.13 with patch-2.4.14pre3 applied:

make -C cramfs modules
make[2]: Entering directory `/user2/src/linux-2.4.13/fs/cramfs'
gcc -D__KERNEL__ -I/user2/src/linux-2.4.13/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -DMODULE   -c -o inode.o inode.c
gcc -D__KERNEL__ -I/user2/src/linux-2.4.13/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -DMODULE  -I /user2/src/linux-2.4.13/fs/inflate_fs -c -o
uncompress.o uncompress.c
uncompress.c:21: linux/zlib_fs.h: No such file or directory
uncompress.c:23: parse error before `stream'
uncompress.c:23: warning: type defaults to `int' in declaration of
`stream'
uncompress.c:23: warning: data definition has no type or storage class
uncompress.c: In function `cramfs_uncompress_block':
uncompress.c:31: request for member `next_in' in something not a structure
[snip]
make[2]: *** [uncompress.o] Error 1
make[2]: Leaving directory `/user2/src/linux-2.4.13/fs/cramfs'
......

Kees

