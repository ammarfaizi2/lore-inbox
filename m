Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSKEAEo>; Mon, 4 Nov 2002 19:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263252AbSKEAEW>; Mon, 4 Nov 2002 19:04:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15343 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263246AbSKEAED>; Mon, 4 Nov 2002 19:04:03 -0500
Date: Tue, 5 Nov 2002 01:10:31 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Dave Kleikamp <shaggy@shaggy.austin.ibm.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.46
Message-ID: <20021105001031.GA3348@fs.tum.de>
References: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 03:13:04PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.45 to v2.5.46
> ============================================
>...
> Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
>...
>   o JFS: add posix acls
>...

It seems that at least one file is missing:

<--  snip  -->

...
  gcc -Wp,-MD,fs/jfs/.super.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-D_JFS_4K  -DKBUILD_BASENAME=super   -c -o fs/jfs/super.o fs/jfs/super.c
fs/jfs/super.c:31: jfs_acl.h: No such file or directory
...
make[2]: *** [fs/jfs/super.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

