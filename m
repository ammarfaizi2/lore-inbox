Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316826AbSE1QUH>; Tue, 28 May 2002 12:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316837AbSE1QUG>; Tue, 28 May 2002 12:20:06 -0400
Received: from ares.sdinet.de ([195.21.215.20]:39948 "HELO ares.sdinet.de")
	by vger.kernel.org with SMTP id <S316826AbSE1QUF>;
	Tue, 28 May 2002 12:20:05 -0400
Date: Tue, 28 May 2002 18:20:08 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre8-ac5 compile error on alpha
Message-ID: <Pine.LNX.4.44.0205281818130.9506-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi...

make[1]: Leaving directory `/usr/src/linux'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6   -DKBUILD_BASENAME=main
-c -o init/main.o init/main.c
In file included from init/main.c:30:
/usr/src/linux/include/linux/suspend.h:4: asm/suspend.h: No such file or
directory
In file included from /usr/src/linux/include/asm/semaphore.h:16,
                 from /usr/src/linux/include/linux/fs.h:200,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/linux/rwsem.h: In function `down_read_trylock':
/usr/src/linux/include/linux/rwsem.h:57: warning: implicit declaration of
function `__down_read_trylock'
/usr/src/linux/include/linux/rwsem.h: In function `down_write_trylock':
/usr/src/linux/include/linux/rwsem.h:79: warning: implicit declaration of
function `__down_write_trylock'
make: *** [init/main.o] Error 1


c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

