Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSEaES6>; Fri, 31 May 2002 00:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSEaES5>; Fri, 31 May 2002 00:18:57 -0400
Received: from [210.19.28.11] ([210.19.28.11]:62118 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S314811AbSEaES4> convert rfc822-to-8bit; Fri, 31 May 2002 00:18:56 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Corporal Pisang <corporal_pisang@counter-strike.com.my>
Organization: Counter-Strike.com.my
To: linux-kernel@vger.kernel.org
Subject: 2.5.19 compile error (undefined reference to `idescsi_init')
Date: Fri, 31 May 2002 12:25:22 +0800
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205311225.22336.corporal_pisang@counter-strike.com.my>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this error while trying to compile 2.5.19.

make[1]: Leaving directory `/usr/src/linux/arch/i386/pci'
Generating build number
make[1]: Entering directory `/usr/src/linux/init'
Generating ../include/linux/compile.h
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon     
-DKBUILD_BASENAME=version  -c -o version.o version.c
 ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/linux/init'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o 
--start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o /usr/src/linux/arch/i386/lib/lib.a 
/usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a 
drivers/built-in.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
drivers/built-in.o: In function `ata_module_init':
drivers/built-in.o(.text.init+0x5666): undefined reference to `idescsi_init'
make: *** [vmlinux] Error 1


Regards.
-- 
-Ubaida-
 
