Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319406AbSIFWAp>; Fri, 6 Sep 2002 18:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319407AbSIFWAp>; Fri, 6 Sep 2002 18:00:45 -0400
Received: from wilder.valley.net ([198.115.160.76]:53773 "EHLO
	wilder.valley.net") by vger.kernel.org with ESMTP
	id <S319406AbSIFWAo>; Fri, 6 Sep 2002 18:00:44 -0400
Message-ID: <3D7926C0.7010906@valley.net>
Date: Fri, 06 Sep 2002 18:05:52 -0400
From: Adam Johnson <adamj@valley.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem: kernel 2.5.33 won't compile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I get this error message when I try to compile 2.5.33:

 Generating build number
make[1]: Entering directory `/usr/src/linux-2.5.33/init'
  Generating /usr/src/linux-2.5.33/include/linux/compile.h (updated)
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.33/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=version   -c -o version.o version.c
   ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/linux-2.5.33/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o 
--start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o 
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o 
/usr/src/linux-2.5.33/arch/i386/lib/lib.a lib/lib.a 
/usr/src/linux-2.5.33/arch/i386/lib/lib.a drivers/built-in.o 
sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
drivers/built-in.o(.data+0x2d8d4): undefined reference to `local symbols 
in discarded section .text.exit'
make: *** [vmlinux] Error 1


