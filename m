Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310258AbSDDTXp>; Thu, 4 Apr 2002 14:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310241AbSDDTXg>; Thu, 4 Apr 2002 14:23:36 -0500
Received: from pool-151-204-76-218.delv.east.verizon.net ([151.204.76.218]:7441
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S310435AbSDDTXX>; Thu, 4 Apr 2002 14:23:23 -0500
Date: Thu, 4 Apr 2002 14:23:42 -0500
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: linux-kernel@vger.kernel.org
Subject: [MIPS] 2.4.19-pre5 compile issue?
Message-ID: <20020404142342.A14268@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Compiling 2.4.19-pre5 on a R5000 Indy IP22  I get this error:

gcc -I /usr/src/linux-2.4.18/include/asm/gcc -D__KERNEL__i -I/usr/src/linux-2.4.1
8/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno
-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mcpu=r5000
-mips2 -Wa,
--trap -pipe   -DKBUILD_BASENAME=signal  -c -o signal.o signal.c
signal.c: In function `do_signal':
signal.c:573: `PER_LINUX' undeclared (first use in this function)
signal.c:573: (Each undeclared identifier is reported only once
signal.c:573: for each function it appears in.)
make[1]: *** [signal.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.18/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2

	Anyone have any ideas?

--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net:8008/~magamo/index.htm
