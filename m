Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318432AbSIFJcY>; Fri, 6 Sep 2002 05:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318435AbSIFJcY>; Fri, 6 Sep 2002 05:32:24 -0400
Received: from ipx.zarz.agh.edu.pl ([149.156.125.1]:23300 "EHLO
	zarz.agh.edu.pl") by vger.kernel.org with ESMTP id <S318432AbSIFJcX>;
	Fri, 6 Sep 2002 05:32:23 -0400
Date: Fri, 6 Sep 2002 11:22:54 +0200 (CEST)
From: "Wojciech \"Sas\" Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu
Subject: [long] 2.4.19 and O(1) Scheduler [PPC]
Message-ID: <Pine.LNX.4.44L.0209061117490.26261-100000@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I try to compile kernel 2.4.19 with sched-2.4.19-rc2-A4.
And: 

gcc -D__KERNEL__ -I/home/users/cieciwa/rpm/BUILD/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/fs.h:26,
                 from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/capability.h:17,
                 from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/binfmts.h:5,
                 from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/sched.h:9,
                 from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/mm.h:4,
                 from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/slab.h:14,
                 from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/asm/bitops.h: In function `set_bit':
/home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/asm/bitops.h:42: parse error before `PPC405_ERR77'
/home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/asm/bitops.h:37: warning: unused variable `p'
/home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/asm/bitops.h:36: warning: unused variable `mask'
[...]

gcc is in version 2.95.4

Any ideas ?

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}

