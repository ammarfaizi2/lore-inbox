Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292761AbSBVK3f>; Fri, 22 Feb 2002 05:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292783AbSBVK30>; Fri, 22 Feb 2002 05:29:26 -0500
Received: from hera.reef.com ([195.138.195.148]:49132 "EHLO hera.reef.com")
	by vger.kernel.org with ESMTP id <S292761AbSBVK3P>;
	Fri, 22 Feb 2002 05:29:15 -0500
X-WebMail-UserID: bogomips
Date: Fri, 22 Feb 2002 11:26:33 +0100
From: bogomips <bogomips@nirvanet.net>
To: users@lists.freeswan.org
Cc: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00002120
Subject: scripts/Menuconfig: MCmenu7: command not found
Message-ID: <3C6C7121@webmail.nirvanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have to make freeswan running of a RH 6.2 kernel 2.2.20 gateway.

Unfortunetely, here is what I got after menugo.

Can anybody help me?

Do I have to patch something?

Regards & thank you in advance,

Bogomips

___________________________________________________

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu7: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make[1]: *** [menuconfig] Error 1
make[1]: Leaving directory `/usr/src/linux'
make: [mcf] Error 2 (ignored)
cd lib ; make
make[1]: Entering directory `/usr/kernel/freeswan-1.95/lib'
ln -s ../libdes/des.h
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o addrtoa.o addrtoa.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o addrtot.o addrtot.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o addrtypeof.o addrtypeof.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o anyaddr.o anyaddr.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o atoaddr.o atoaddr.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o atoasr.o atoasr.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o atosa.o atosa.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o atosubnet.o atosubnet.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o atoul.o atoul.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o copyright.o copyright.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o datatot.o datatot.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o goodmask.o goodmask.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o initaddr.o initaddr.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o initsaid.o initsaid.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o initsubnet.o initsubnet.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o optionsfrom.o optionsfrom.c
cc -I. -g -O3 -Wall -Wpointer-arith -Wcast-qual -Wstrict-prototypes 
-Wbad-function-cast    -c -o pfkey_v2_build.o pfkey_v2_build.c
In file included from pfkey_v2_build.c:63:
../pluto/defs.h:95: gmp.h: No such file or directory
make[1]: *** [pfkey_v2_build.o] Error 1
make[1]: Leaving directory `/usr/kernel/freeswan-1.95/lib'
make: *** [programs] Error 2
[root@beltram freeswan-1.95]# ls
BUGS     COPYING  INSTALL   Makefile.inc  README  klips  libdes      pluto   
testing  zlib
CHANGES  CREDITS  Makefile  Makefile.ver  doc     lib    out.kpatch  rpm.in  
utils
[root@beltram freeswan-1.95]#

_________________________________________________
OpenPGP key @ www.keyserver.net
86A2 AEBA 0223 2D9F 78A4 60B7 855E F620 8D56 B690

