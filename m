Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbSBJWjV>; Sun, 10 Feb 2002 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284794AbSBJWjL>; Sun, 10 Feb 2002 17:39:11 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:9960 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S284717AbSBJWix>; Sun, 10 Feb 2002 17:38:53 -0500
Message-ID: <3C66F670.9000305@nyc.rr.com>
Date: Sun, 10 Feb 2002 17:38:40 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.4-pre6 compile trouble
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5.4/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686   -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o 
sched.o sched.c
sched.c: In function `schedule':
sched.c:664: `global_irq_holder' undeclared (first use in this function)
sched.c:664: (Each undeclared identifier is reported only once
sched.c:664: for each function it appears in.)
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.4/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.4/kernel'
make: *** [_dir_kernel] Error 2

