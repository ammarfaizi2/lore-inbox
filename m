Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264911AbSJPHWX>; Wed, 16 Oct 2002 03:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264941AbSJPHWX>; Wed, 16 Oct 2002 03:22:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42229 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264911AbSJPHWW>; Wed, 16 Oct 2002 03:22:22 -0400
Date: Wed, 16 Oct 2002 09:28:15 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>, <rread@clusterfs.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
In-Reply-To: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0210160922280.20607-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.42 to v2.5.43
> ============================================
>...
> <rread@clusterfs.com>:
>   o InterMezzo for 2.5
>...

It seems some required files weren't included in 2.5.43:

<--  snip  -->

...
  gcc -Wp,-MD,fs/intermezzo/.cache.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=cache   -c -o fs/intermezzo/cache.o
fs/intermezzo/cache.c
In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h:30: linux/intermezzo_lib.h: No such file or directory
include/linux/intermezzo_fs.h:31: linux/intermezzo_idl.h: No such file or directory
...
make[2]: *** [fs/intermezzo/cache.o] Error 1

<--  snip  -->


cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed


