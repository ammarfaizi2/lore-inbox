Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292265AbSBUAdT>; Wed, 20 Feb 2002 19:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292598AbSBUAdJ>; Wed, 20 Feb 2002 19:33:09 -0500
Received: from WARSL401PIP6.highway.telekom.at ([195.3.96.113]:65366 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S292265AbSBUAdF>;
	Wed, 20 Feb 2002 19:33:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Gerald Roth <gerald.roth@aon.at>
Organization: University of Graz, Austria
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-rc2-aa1 compilation failure
Date: Thu, 21 Feb 2002 01:30:51 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020221003306Z292265-889+4243@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[3]: Entering directory `/usr/src/linux/fs/reiserfs'
make[3]: Circular /usr/src/linux/include/asm/pgalloc.h <- 
/usr/src/linux/include/linux/highmem.h dependency dropped.
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    
-DKBUILD_BASENAME=bitmap  -c -o bitmap.o bitmap.c
bitmap.c: In function `reiserfs_free_prealloc_block':
bitmap.c:142: warning: unused variable `s'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    
-DKBUILD_BASENAME=do_balan  -c -o do_balan.o do_balan.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    
-DKBUILD_BASENAME=namei  -c -o namei.o namei.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    
-DKBUILD_BASENAME=inode  -c -o inode.o inode.c
inode.c: In function `reiserfs_direct_io':
inode.c:2097: `filp' undeclared (first use in this function)
inode.c:2097: (Each undeclared identifier is reported only once
inode.c:2097: for each function it appears in.)
make[3]: *** [inode.o] Error 1
make[3]: Leaving directory `/usr/src/linux/fs/reiserfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/fs/reiserfs'
make[1]: *** [_subdir_reiserfs] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [_dir_fs] Error 2

hth
gerald
