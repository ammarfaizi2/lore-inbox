Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268172AbRG2VMM>; Sun, 29 Jul 2001 17:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268171AbRG2VMC>; Sun, 29 Jul 2001 17:12:02 -0400
Received: from [208.139.225.12] ([208.139.225.12]:10144 "EHLO bish.net")
	by vger.kernel.org with ESMTP id <S268157AbRG2VLr>;
	Sun, 29 Jul 2001 17:11:47 -0400
Date: Sun, 29 Jul 2001 17:10:40 -0400 (EDT)
From: Mark <mark@bish.net>
Reply-To: Mark <mark@bish.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel version 2.4.7 compile errors
Message-ID: <Pine.LNX.3.96.1010729170618.6078B-100000@bish.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Note: I'm not subscribed, please Cc: mark@bish.net

I'm trying to compile 2.4.7 with resiser support and I get this:

make[3]: Entering directory `/usr/src/linux/fs/reiserfs'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o inode.o inode.c
inode.c: In function `reiserfs_get_block':
inode.c:803: warning: implicit declaration of function
`journal_transactioo_should_end'
inode.c:812: `retvcl' undeclared (first use in this function)
inode.c:812: (Each undeclared identifier is reported only once
inode.c:812: for each function it appears in.)
inode.c:812: parse error before `)'
inode.c: In function `init_inode':
inode.c:870: warning: implicit declaration of function `INIT_NIST_HEAD'
inode.c:876: warning: implicit declaration of function
`knode_items_version'
inode.c:876: invalid lvalue in assignment
inode.c:878: parse error before `>'
inode.c:882: structure has no member named `sd_atkme'
inode.c:889: `inofe' undeclared (first use in this function)
make[3]: *** [inode.o] Error 1
make[3]: Leaving directory `/usr/src/linux/fs/reiserfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/fs/reiserfs'
make[1]: *** [_subdir_reiserfs] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [_dir_fs] Error 2

I'm using the same .config as I was in 2.4.4.  I haven't had the time to
compare the two files to see what is different.  If I don't get a solution
in the next day or so I will.



------------------------------------------------------------------------
| Mark Bishop  (mark@bish.net)         |             Computer Engineer |
| 813.258.2390                         |             Network Engineer  |
| http://bish.net                      |          Embedded Programmer  |


