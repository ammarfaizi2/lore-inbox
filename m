Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318438AbSGSDSb>; Thu, 18 Jul 2002 23:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318439AbSGSDSb>; Thu, 18 Jul 2002 23:18:31 -0400
Received: from web9203.mail.yahoo.com ([216.136.129.26]:55950 "HELO
	web9203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318438AbSGSDSa>; Thu, 18 Jul 2002 23:18:30 -0400
Message-ID: <20020719032132.99401.qmail@web9203.mail.yahoo.com>
Date: Thu, 18 Jul 2002 20:21:32 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re:inux-2.4.19-rc2aa1 (RH7.2 kgcc: Internal compiler error in function add_pending_init)
To: linux-kernel@vger.kernel.org
Cc: s_sokolov@avtodor.gorny.ru
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only time this ever happened to me, it turned out one of my 
RAM sticks had failed. Just out of curiosity, have you had any 
oopses recently?

Hi All !!
When I try compile kernel on my RH7.2
with CC=kgcc, I receive this message:

kgcc  -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.4.19-rc2aa1/include -traditional \
-c head.S -o head.o kgcc  -D__KERNEL__ -I/usr/src/linux-2.4.19-rc2aa1/include -Wall \
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-st rict-aliasing -fno-common \
-fomit-frame-pointer -pipe  -march=i686   -nostdinc -I /usr/lib/gcc-lib/i386-redhat- \
linux/egcs-2.91.66/include -DKBUILD_BASENAME=init_task  -c -o init_task.o init_task.c \
../../gcc/c-typeck.c:5945: Internal compiler error in function add_pending_init \
make[1]: *** [init_task.o] Error 1 make[1]: Leaving directory \
                `/usr/src/linux-2.4.19-rc2aa1/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

__________________________________________________
Do You Yahoo!?
Yahoo! Autos - Get free new car price quotes
http://autos.yahoo.com
