Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSGIMj7>; Tue, 9 Jul 2002 08:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSGIMj6>; Tue, 9 Jul 2002 08:39:58 -0400
Received: from basket.ball.reliam.net ([213.91.6.7]:39698 "HELO
	basket.ball.reliam.net") by vger.kernel.org with SMTP
	id <S314707AbSGIMj4>; Tue, 9 Jul 2002 08:39:56 -0400
Date: Tue, 9 Jul 2002 14:43:49 +0200
From: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Mailer: The Bat! (v1.60q)
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Priority: 3 (Normal)
Message-ID: <01742490.20020709144349@uni.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] 2.4 IDE core for 2.5
In-Reply-To: <20020709102249.GA20870@suse.de>
References: <20020709102249.GA20870@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens,

Tuesday, July 9, 2002, 12:22:49 PM, you wrote:

JA> *.kernel.org://pub/linux/kernel/people/axboe/patches/v2.5/2.5.25/

After downloading each of the 7 .gz-patches, applying them without any
complains, I started to compile the new bzImage, but I got an error
in relation to the FAT support. By switching this support off
everything'll compile without any further problem though, and I can
boot from this image even.. :-)

<out of subject>
Before appending the error messages I want to know if `shm' is named
`shmem' in 2.5 (it seems so anyway)?
</out of subject>

Hope it will be fixed ASAP.

FYI:
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y

Make's complaints:
====================
make[1]: Entering directory `/usr/src/linux-2.5.25/scripts'
make[1]: Leaving directory `/usr/src/linux-2.5.25/scripts'
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make[1]: Entering directory `/usr/src/linux-2.5.25/init'
  Generating /usr/src/linux-2.5.25/include/linux/compile.hdnsdomainname: Host name lookup failure
 (unchanged)
make[1]: Leaving directory `/usr/src/linux-2.5.25/init'
make[1]: Entering directory `/usr/src/linux-2.5.25/kernel'
make[1]: Leaving directory `/usr/src/linux-2.5.25/kernel'
make[1]: Entering directory `/usr/src/linux-2.5.25/mm'
make[1]: Leaving directory `/usr/src/linux-2.5.25/mm'
make[1]: Entering directory `/usr/src/linux-2.5.25/fs'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/devfs'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/devfs'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/devpts'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/devpts'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/driverfs'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/driverfs'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/ext2'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/ext2'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/ext3'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/ext3'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/fat'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/fat'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/isofs'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/isofs'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/jbd'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/jbd'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/nls'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/nls'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/partitions'
  gcc -Wp,-MD,./.msdos.o.d -D__KERNEL__ -I/usr/src/linux-2.5.25/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=msdos -DEXPORT_SYMTAB  -c -o msdos.o msdos.c
In file included from msdos.c:32:
/usr/src/linux-2.5.25/include/linux/ide.h:651: field `taskfile' has incomplete type
/usr/src/linux-2.5.25/include/linux/ide.h:652: field `hobfile' has incomplete type
make[2]: *** [msdos.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/partitions'
make[1]: *** [partitions] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.25/fs'
make: *** [fs] Error 2


-- 
cheers,
  Tobias

http://freebits.org

