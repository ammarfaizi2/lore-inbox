Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131231AbRCWQbk>; Fri, 23 Mar 2001 11:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbRCWQb3>; Fri, 23 Mar 2001 11:31:29 -0500
Received: from gate.unige.ch ([129.194.8.77]:24030 "EHLO gate.unige.ch")
	by vger.kernel.org with ESMTP id <S131231AbRCWQbS>;
	Fri, 23 Mar 2001 11:31:18 -0500
Date: Fri, 23 Mar 2001 17:30:37 +0100
From: Pfenniger Daniel <daniel.pfenniger@obs.unige.ch>
Subject: 2.4.2-ac23 compile error in setup.c
To: linux-kernel@vger.kernel.org
Message-id: <3ABB7A2D.1DC3D658@obs.unige.ch>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: fr-CH, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, here is the error message

make[1]: Entering directory `/usr/src/linux-test/linux/arch/i386/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-test/linux/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o setup.o setup.c
setup.c: In function `identify_cpu':
setup.c:2280: `tsc_disable' undeclared (first use in this function)
setup.c:2280: (Each undeclared identifier is reported only once
setup.c:2280: for each function it appears in.)
setup.c: In function `get_cpuinfo':
setup.c:2378: warning: unused variable `x86_udelay_tsc'
make[1]: *** [setup.o] Error 1
make[1]: Leaving directory `/usr/src/linux-test/linux/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2


	Dan
