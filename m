Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263189AbSJFCaC>; Sat, 5 Oct 2002 22:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263192AbSJFCaC>; Sat, 5 Oct 2002 22:30:02 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:6100 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S263189AbSJFCaC> convert rfc822-to-8bit; Sat, 5 Oct 2002 22:30:02 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.40 (-ac4): IDE as modules anyone?
Date: Sun, 6 Oct 2002 04:35:28 +0200
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210060435.28245.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Entering directory `/usr/src/linux-2.5.40-ac4/drivers/ide'
  gcc -Wp,-MD,./.ide.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40-ac4/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -mcpu=k6 
-march=i686 -malign-functions=4 -fschedule-insns2 -fexpensive-optimizations  
-I/usr/src/linux-2.5.40-ac4/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE -include 
/usr/src/linux-2.5.40-ac4/include/linux/modversions.h   -DKBUILD_BASENAME=ide 
-DEXPORT_SYMTAB  -c -o ide.o ide.c
ide.c:3575: redefinition of `init_module'
ide.c:3553: `init_module' previously defined here
ide.c: In function `cleanup_module':
ide.c:3598: warning: implicit declaration of function `bus_unregister'
{standard input}: Assembler messages:
{standard input}:9163: Error: symbol `init_module' is already defined

Have a nice Sunday.

-Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)

