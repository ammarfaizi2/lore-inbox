Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130737AbRBWXTa>; Fri, 23 Feb 2001 18:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRBWXTL>; Fri, 23 Feb 2001 18:19:11 -0500
Received: from [38.194.216.192] ([38.194.216.192]:53777 "HELO
	vulcan.jvpbill.com") by vger.kernel.org with SMTP
	id <S130737AbRBWXTE>; Fri, 23 Feb 2001 18:19:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: jorgp <jorgp@bartnet.net>
Reply-To: jorgp@bartnet.net
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.2 and hamradio as module
Date: Fri, 23 Feb 2001 17:22:07 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01022317220700.04453@vulcan.jvpbill.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this was built from stock 2.4.2 kernel.


gcc -D__KERNEL__ -I/usr/src/RPM/BUILD/linux/include -Wall -Wstrict-prototypes 
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe 
-mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include 
/usr/src/RPM/BUILD/linux/include/linux/modversions.h   -c -o mkiss.o mkiss.c
gcc -D__KERNEL__ -I/usr/src/RPM/BUILD/linux/include -Wall -Wstrict-prototypes 
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe 
-mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include 
/usr/src/RPM/BUILD/linux/include/linux/modversions.h   -c -o 6pack.o 6pack.c
6pack.c: In function `sixpack_init_driver':
6pack.c:714: `KMALLOC_MAXSIZE' undeclared (first use in this function)
6pack.c:714: (Each undeclared identifier is reported only once
6pack.c:714: for each function it appears in.)
make[2]: *** [6pack.o] Error 1
make[2]: Leaving directory `/usr/src/RPM/BUILD/linux/drivers/net/hamradio'
make[1]: *** [_modsubdir_net/hamradio] Error 2
make[1]: Leaving directory `/usr/src/RPM/BUILD/linux/drivers'
make: *** [_mod_drivers] Error 2

Thanks
Jorg
