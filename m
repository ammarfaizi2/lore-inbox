Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318724AbSG0Jux>; Sat, 27 Jul 2002 05:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318726AbSG0Jux>; Sat, 27 Jul 2002 05:50:53 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:58628 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318724AbSG0Juw>; Sat, 27 Jul 2002 05:50:52 -0400
Message-ID: <33116.192.168.0.100.1027764050.squirrel@thuis.zwanebloem.nl>
Date: Sat, 27 Jul 2002 12:00:50 +0200 (CEST)
Subject: [2.5.29] APM build error
From: "Tommy Faasen" <faasen@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I got this error:

make[1]: Entering directory
`/home/it0/download/kernelstuff/linux-2.5.29/init'
  Generating
/home/it0/download/kernelstuff/linux-2.5.29/include/linux/compile.h
(updated)
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__
-I/home/it0/download/kernelstuff/linux-2.5.29/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=version   -c -o version.o version.c
   ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/home/it0/download/kernelstuff/linux-2.5.29/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o
arch/i386/kernel/init_task.o init/init.o --start-group
arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o security/built-in.o
/home/it0/download/kernelstuff/linux-2.5.29/arch/i386/lib/lib.a
lib/lib.a
/home/it0/download/kernelstuff/linux-2.5.29/arch/i386/lib/lib.a
drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o
--end-group -o vmlinux
arch/i386/kernel/kernel.o: In function `apm_get_info':
arch/i386/kernel/kernel.o(.text+0xbee7): undefined reference to
`num_possible_cpus'
arch/i386/kernel/kernel.o: In function `apm':
arch/i386/kernel/kernel.o(.text+0xc0e0): undefined reference to
`num_possible_cpus'
arch/i386/kernel/kernel.o(.text+0xc24a): undefined reference to
`num_possible_cpus'
arch/i386/kernel/kernel.o: In function `apm_init':
arch/i386/kernel/kernel.o(.text.init+0x4166): undefined reference to
`num_possible_cpus'
arch/i386/kernel/kernel.o(.text.init+0x42f4): undefined reference to
`num_possible_cpus'
make: *** [vmlinux] Error 1



