Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133025AbRAUBny>; Sat, 20 Jan 2001 20:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133026AbRAUBnn>; Sat, 20 Jan 2001 20:43:43 -0500
Received: from seyn.maisel.int-evry.fr ([157.159.41.100]:55936 "HELO
	seyn.minet.net") by vger.kernel.org with SMTP id <S133025AbRAUBnk>;
	Sat, 20 Jan 2001 20:43:40 -0500
Date: Sun, 21 Jan 2001 02:45:16 +0100
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.1-pre9 does not compile on r128.c
Message-ID: <20010121024516.A6492@minet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: pierre@minet.net (Pierre CORCINOS)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

result of the compilation :

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i686 -DMODULE -DMODVERSIONS -include
/usr/src/linux/include/linux/modversions.h   -DEXPORT_SYMTAB -c r128_drv.c
r128_drv.c:124: `DRM_IOCTL_R128_PACKET' undeclared here (not in a function)
r128_drv.c:124: nonconstant array index in initializer
r128_drv.c:124: (near initialization for `r128_ioctls')
{standard input}: Assembler messages:
{standard input}:8: Warning: Ignoring changed section attributes for .modinfo
make[3]: *** [r128_drv.o] Erreur 1

ver_linux :

Linux seyn 2.4.1-pre8 #3 dim jan 21 01:12:23 CET 2001 i686 unknown
Kernel modules         2.4.1
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ntfs nls_iso8859-15 nls_cp437 vfat fat emu10k1 soundcore

Congratulation for your job

-- 
Pierre CORCINOS					<pierre@minet.net>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
