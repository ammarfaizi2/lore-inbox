Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279728AbRJ0C0J>; Fri, 26 Oct 2001 22:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279760AbRJ0C0C>; Fri, 26 Oct 2001 22:26:02 -0400
Received: from [203.94.150.195] ([203.94.150.195]:9886 "HELO
	gemini.faredge.com.au") by vger.kernel.org with SMTP
	id <S279728AbRJ0CZs>; Fri, 26 Oct 2001 22:25:48 -0400
From: "Chris Herrmann" <chris@faredge.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.12 ieee1284 errors
Date: Sat, 27 Oct 2001 12:26:47 +1000
Message-ID: <001d01c15e8e$d4a1e030$c8965ecb@faredge.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm attempting to compile a vanilla 2.4.12 kernel, and keep getting bumped
at:

make[2]: Entering directory `/usr/src/linux/drivers/parport'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-tri
graphs -O2 -fomit-fram
e-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=
2 -march=i686 -DMODULE
 -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o
share.o share.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-tri
graphs -O2 -fomit-fram
e-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=
2 -march=i686 -DMODULE
 -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o
ieee1284.o ieee1284.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-tri
graphs -O2 -fomit-fram
e-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=
2 -march=i686 -DMODULE
 -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o
ieee1284_ops.o ieee1284
_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this
function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this
function)
make[2]: *** [ieee1284_ops.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/parport'
make[1]: *** [_modsubdir_parport] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

Any ideas how I can get around this?

Thanks

Chris Herrmann
Far Edge Technology

p. 02 99553640
f. 02 99547994
m. 0403 393309
http://www.faredge.com.au

