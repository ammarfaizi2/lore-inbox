Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272953AbRIHFOC>; Sat, 8 Sep 2001 01:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272958AbRIHFNx>; Sat, 8 Sep 2001 01:13:53 -0400
Received: from kiln.isn.net ([198.167.161.1]:55368 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S272953AbRIHFNo>;
	Sat, 8 Sep 2001 01:13:44 -0400
Message-ID: <3B99A8C2.56E88CE3@isn.net>
Date: Sat, 08 Sep 2001 02:12:34 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.10-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: torvalds@transmeta.com
Subject: 2.4.10-pre5
Content-Type: multipart/mixed;
 boundary="------------E4B5012D4E82886E782CD55E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E4B5012D4E82886E782CD55E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

gcc-3.0
log should be self explanatory.
cc me if rqd.
Garst
--------------E4B5012D4E82886E782CD55E
Content-Type: text/plain; charset=us-ascii;
 name="makemodules.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="makemodules.log"

make[2]: Entering directory `/usr/src/linux/drivers/block'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE   -c -o rd.o rd.c
rd.c: In function `rd_ioctl':
rd.c:262: invalid type argument of `->'
rd.c: In function `rd_cleanup':
rd.c:375: too few arguments to function `blkdev_put'
make[2]: *** [rd.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2
Command exited with non-zero status 2
4.13user 0.37system 0:04.50elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (3849major+4162minor)pagefaults 0swaps

--------------E4B5012D4E82886E782CD55E--

