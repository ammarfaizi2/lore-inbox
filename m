Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312248AbSDNMlD>; Sun, 14 Apr 2002 08:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312253AbSDNMlC>; Sun, 14 Apr 2002 08:41:02 -0400
Received: from web10401.mail.yahoo.com ([216.136.130.93]:55468 "HELO
	web10401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312248AbSDNMlB>; Sun, 14 Apr 2002 08:41:01 -0400
Message-ID: <20020414124101.1434.qmail@web10401.mail.yahoo.com>
Date: Sun, 14 Apr 2002 22:41:01 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Another compile error with 2.4.19-pre6aa1
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Me again, after unselect the Texas Instrument PCILynx
support in config I proceed the make modules and this
time I got.

gcc -D__KERNEL__ -I/home/sk/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -fno-strength-reduce
-fomit-frame-pointer -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE
-DMODVERSIONS -include
/home/sk/src/linux/include/linux/modversions.h 
-nostdinc -I
/usr/lib/gcc-lib/i586-mandrake-linux-gnu/2.96/include
-DKBUILD_BASENAME=sa1100_generic  -c -o
sa1100_generic.o sa1100_generic.c
sa1100_generic.c:40:27: linux/cpufreq.h: No such file
or directory
sa1100_generic.c:50:27: linux/cpufreq.h: No such file
or directory
sa1100_generic.c:58:26: asm/hardware.h: No such file
or directory
sa1100_generic.c:62:30: asm/arch/assabet.h: No such
file or directory
sa1100_generic.c: In function
`sa1100_pcmcia_set_io_map':
sa1100_generic.c:595: warning: implicit declaration of
function `cpufreq_get'
sa1100_generic.c:597: `MECR' undeclared (first use in
this function)
sa1100_generic.c:597: (Each undeclared identifier is
reported only once
sa1100_generic.c:597: for each function it appears
in.)
sa1100_generic.c: In function
`sa1100_pcmcia_set_mem_map':
sa1100_generic.c:703: `MECR' undeclared (first use in
this function)
sa1100_generic.c: In function
`sa1100_pcmcia_proc_status':
sa1100_generic.c:751: `MECR' undeclared (first use in
this function)
sa1100_generic.c: In function
`sa1100_pcmcia_driver_init':
sa1100_generic.c:1079: warning: implicit declaration
of function `_PCMCIA'
sa1100_generic.c:1079: `PCMCIASp' undeclared (first
use in this function)
sa1100_generic.c:1095: warning: implicit declaration
of function `_PCMCIAAttr'
sa1100_generic.c:1096: warning: implicit declaration
of function `_PCMCIAMem'
sa1100_generic.c:1097: warning: implicit declaration
of function `_PCMCIAIO'
sa1100_generic.c:1110: `MECR' undeclared (first use in
this function)
sa1100_generic.c: In function
`sa1100_pcmcia_driver_shutdown':
sa1100_generic.c:1165: `PCMCIASp' undeclared (first
use in this function)
make[2]: *** [sa1100_generic.o] Error 1
make[2]: Leaving directory
`/home/sk/src/linux/drivers/pcmcia'
make[1]: *** [_modsubdir_pcmcia] Error 2
make[1]: Leaving directory
`/home/sk/src/linux/drivers'
make: *** [_mod_drivers] Error 2


=====
Steve Kieu

http://messenger.yahoo.com.au - Yahoo! Messenger
- A great way to communicate long-distance for FREE!
