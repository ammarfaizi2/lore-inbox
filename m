Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSFTMls>; Thu, 20 Jun 2002 08:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSFTMlr>; Thu, 20 Jun 2002 08:41:47 -0400
Received: from 213-4-13-153.uc.nombres.ttd.es ([213.4.13.153]:260 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S310190AbSFTMlr>; Thu, 20 Jun 2002 08:41:47 -0400
Message-ID: <3D11CD63.70505@borak.es>
Date: Thu, 20 Jun 2002 14:41:07 +0200
From: Felipe Alfaro Solana <falfaro@borak.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.23 won't compile
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  _Summary_

    Can't get linux kernel 2.5.23 to compile with success using config
    options in the attached file "config-2.5.23"

_Full description_

    When trying to compile the kernel using config options in
    "config-2.5.13", I get the following erros during a "make bzImage":

    make[1]: Entering directory `/usr/src/linux-2.5.23/kernel'
      gcc -Wp,-MD,./.sched.o.d -D__KERNEL__
    -I/usr/src/linux-2.5.23/include -Wall -Wstrict-prototypes
    -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
    -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc
    -iwithprefix include    -fno-omit-frame-pointer
    -DKBUILD_BASENAME=sched   -c -o sched.o sched.c
    sched.c: In function `sys_sched_setaffinity':
    sched.c:1332: `cpu_online_map' undeclared (first use in this function)
    sched.c:1332: (Each undeclared identifier is reported only once
    sched.c:1332: for each function it appears in.)
    sched.c: In function `sys_sched_getaffinity':
    sched.c:1391: `cpu_online_map' undeclared (first use in this function)
    make[1]: *** [sched.o] Error 1
    make[1]: Leaving directory `/usr/src/linux-2.5.23/kernel'
    make: *** [kernel] Error 2

_Keywords
_

    Compile, Kernel


