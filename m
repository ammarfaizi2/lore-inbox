Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288870AbSAERAd>; Sat, 5 Jan 2002 12:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288871AbSAERAN>; Sat, 5 Jan 2002 12:00:13 -0500
Received: from aef.wh.Uni-Dortmund.DE ([129.217.129.132]:38138 "EHLO
	ReneEngelhard.local") by vger.kernel.org with ESMTP
	id <S288870AbSAERAJ>; Sat, 5 Jan 2002 12:00:09 -0500
Date: Sat, 5 Jan 2002 17:57:27 +0100
From: Rene Engelhard <mail@rene-engelhard.de>
To: linux-kernel@vger.kernel.org
Subject: Compile error 2.5.2-pre8 (ext3)
Message-ID: <20020105175727.A10286@rene-engelhard.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key: http://www.rene-engelhard.de/gnupg/mykey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following trying to compile linux-2.5.2-pre8...

make[3]: Entering directory
`/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/fs/ext3'
gcc -D__KERNEL__
-I/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o balloc.o balloc.c
gcc -D__KERNEL__
-I/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o bitmap.o bitmap.c
gcc -D__KERNEL__
-I/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o dir.o dir.cgcc -D__KERNEL__
-I/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o file.o file.c
gcc -D__KERNEL__
-I/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o fsync.o fsync.c
gcc -D__KERNEL__
-I/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o ialloc.o ialloc.c
gcc -D__KERNEL__
-I/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o inode.o inode.c
gcc -D__KERNEL__
-I/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o ioctl.o ioctl.c
gcc -D__KERNEL__
-I/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o namei.o namei.c
gcc -D__KERNEL__
-I/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o super.o super.c
super.c: In function `make_rdonly':
super.c:59: invalid operands to binary !=
super.c:62: invalid operands to binary +
make[3]: *** [super.o] Error 1
make[2]: *** [first_rule] Error 2
make[1]: *** [_subdir_ext3] Error 2
make: *** [_dir_fs] Error 2
make[3]: Leaving directory
`/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/fs/ext3'
make[2]: Leaving directory
`/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/fs/ext3'
make[1]: Leaving directory
`/home/rene/Entwicklung/Kernel/linux-2.5.2-pre8/fs'
rene@ReneEngelhard:~/Entwicklung/Kernel/linux-2.5.2-pre8>

Does anyone know what do do here now?
I _have_ to compile the kernel with ext3 because / and all partitions
are ext3...

Rene
-- 
GnuPG:
Key fingerprint = 41FA F208 28D4 7CA5 19BB  7AD9 F859 90B0 248A EB73
Key ID: 248AEB73
Mail an gnupgkey@rene-engelhard.de um den Key zugeschickt zu bekommen
Mail to gnupgkey@rene-engelhard.de to get the key automatically
