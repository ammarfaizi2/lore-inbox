Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313206AbSD3LUg>; Tue, 30 Apr 2002 07:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSD3LUf>; Tue, 30 Apr 2002 07:20:35 -0400
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:55492 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313206AbSD3LUf>; Tue, 30 Apr 2002 07:20:35 -0400
Message-ID: <3CCE7DF8.3FED7178@wanadoo.fr>
Date: Tue, 30 Apr 2002 13:20:24 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre7-ac2 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre7-ac3 does not compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've the following error.
I tried several times, I get always the sig11 from cc at the same place.

make[4]: Entering directory
`/usr/src/kernel-sources-2.4.19-pre7-ac3/fs/ext2'
gcc -D__KERNEL__ -I/usr/src/kernel-sources-2.4.19-pre7-ac3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6  
-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=balloc  -c -o balloc.o balloc.c
balloc.c: In function `ext2_new_block':
balloc.c:524: warning: long unsigned int format, unsigned int arg (arg
4)
balloc.c:397: label `io_error' used but not defined
balloc.c:383: label `out' used but not defined
gcc: Internal compiler error: program cc1 got fatal signal 11
make[4]: *** [balloc.o] Error 1
make[4]: Leaving directory
`/usr/src/kernel-sources-2.4.19-pre7-ac3/fs/ext2'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory
`/usr/src/kernel-sources-2.4.19-pre7-ac3/fs/ext2'
make[2]: *** [_subdir_ext2] Error 2
make[2]: Leaving directory `/usr/src/kernel-sources-2.4.19-pre7-ac3/fs'
make[1]: *** [_dir_fs] Error 2
make[1]: Leaving directory `/usr/src/kernel-sources-2.4.19-pre7-ac3'
make: *** [stamp-build] Error 2

-----
Regards
	Jean-Luc
