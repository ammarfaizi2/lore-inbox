Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319340AbSHQEz1>; Sat, 17 Aug 2002 00:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319341AbSHQEz1>; Sat, 17 Aug 2002 00:55:27 -0400
Received: from smtp-stjh-01-04.rogers.nf.net ([192.75.13.144]:13562 "EHLO
	smtp-stjh-01-04.rogers.nf.net") by vger.kernel.org with ESMTP
	id <S319340AbSHQEz1>; Sat, 17 Aug 2002 00:55:27 -0400
From: "Skidley" <skidley@roadrunner.nf.net>
Date: Sat, 17 Aug 2002 02:29:24 -0230
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.20-pre3
Message-ID: <20020817045924.GC377@hendrix>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/skidley/kernel/linux-2.4.20-pre3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=check  -DEXPORT_SYMTAB -c check.c
check.c: In function `devfs_register_disc':
check.c:328: structure has no member named `number'
check.c:329: structure has no member named `number'
check.c: In function `devfs_register_partitions':
check.c:361: structure has no member named `number'
make[3]: *** [check.o] Error 1
make[3]: Leaving directory
`/home/skidley/kernel/linux-2.4.20-pre3/fs/partitions'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/home/skidley/kernel/linux-2.4.20-pre3/fs/partitions'
make[1]: *** [_subdir_partitions] Error 2
make[1]: Leaving directory `/home/skidley/kernel/linux-2.4.20-pre3/fs'
make: *** [_dir_fs] Error 2

-- 
"I mean they are gonna kill ya so like if ya give em a quick, short, sharp,
shock they won't do it again. Dig it! I mean he got off lightly cuz I would 
have given him a thrashing. I only hit him once. It was only a difference of 
opinion but really... I mean good manners don't cost nothin do they. Eh?"
