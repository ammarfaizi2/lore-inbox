Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbSJPU4E>; Wed, 16 Oct 2002 16:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSJPU4E>; Wed, 16 Oct 2002 16:56:04 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:63366 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261394AbSJPU4D> convert rfc822-to-8bit; Wed, 16 Oct 2002 16:56:03 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.43+: IDE as modules, when?
Date: Wed, 16 Oct 2002 23:01:58 +0200
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210162301.58037.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f drivers/ide/Makefile
  gcc -Wp,-MD,drivers/ide/.ide.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -mcpu=k6 -march=i686 -malign-functions=4 
-fschedule-insns2 -fexpensive-optimizations  -Iarch/i386/mach-generic 
-fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE -include 
include/linux/modversions.h   -DKBUILD_BASENAME=ide -DEXPORT_SYMTAB  -c -o 
drivers/ide/ide.o drivers/ide/ide.c
drivers/ide/ide.c: In function `ide_register_driver_Rsmp_defb87fa':
drivers/ide/ide.c:3459: warning: assignment discards qualifiers from pointer 
target type
drivers/ide/ide.c: At top level:
drivers/ide/ide.c:3563: redefinition of `init_module'
drivers/ide/ide.c:3541: `init_module' previously defined here
drivers/ide/ide.c: In function `cleanup_module':
drivers/ide/ide.c:3585: warning: implicit declaration of function 
`bus_unregister'
{standard input}: Assembler messages:
{standard input}:9108: Error: symbol `init_module' is already defined
make[2]: *** [drivers/ide/ide.o] Error 1
make[1]: *** [drivers/ide] Error 2
make: *** [drivers] Error 2

Thanks,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)

