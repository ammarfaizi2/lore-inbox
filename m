Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317511AbSFRRSN>; Tue, 18 Jun 2002 13:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSFRRSN>; Tue, 18 Jun 2002 13:18:13 -0400
Received: from www.transvirtual.com ([206.14.214.140]:58892 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317511AbSFRRSL>; Tue, 18 Jun 2002 13:18:11 -0400
Date: Tue, 18 Jun 2002 10:18:08 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: latest linus-2.5 BK broken
Message-ID: <Pine.LNX.4.44.0206181016290.5510-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  gcc -Wp,-MD,./.sched.o.d -D__KERNEL__ -I/tmp/fbdev-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -nostdinc -iwithprefix include    -fno-omit-frame-pointer -DKBUILD_BASENAME=sched   -c -o sched.o sched.c
sched.c: In function `sys_sched_setaffinity':
sched.c:1329: `cpu_online_map' undeclared (first use in this function)
sched.c:1329: (Each undeclared identifier is reported only once
sched.c:1329: for each function it appears in.)
sched.c: In function `sys_sched_getaffinity':
sched.c:1389: `cpu_online_map' undeclared (first use in this function)
make[1]: *** [sched.o] Error 1

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

