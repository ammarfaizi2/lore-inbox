Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbSJYNHn>; Fri, 25 Oct 2002 09:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSJYNHn>; Fri, 25 Oct 2002 09:07:43 -0400
Received: from mail.spylog.com ([194.67.35.220]:686 "EHLO mail.spylog.com")
	by vger.kernel.org with ESMTP id <S261400AbSJYNHl>;
	Fri, 25 Oct 2002 09:07:41 -0400
Date: Fri, 25 Oct 2002 17:13:49 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44-ac3 - don't compile.
Message-ID: <20021025131349.GA25980@an.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.


 x86, no SMP.


...
make -f init/Makefile 
  Generating init/../include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic
-fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version
-c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/do_mounts.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
arch/i386/kernel/init_task.o  init/built-in.o --start-group
arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o
ipc/built-in.o  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o
--end-group  -o vmlinux
arch/i386/kernel/built-in.o: In function `MP_processor_info':
arch/i386/kernel/built-in.o(.init.text+0x46a3): undefined reference to `Dprintk'
arch/i386/kernel/built-in.o(.init.text+0x46b6): undefined reference to `Dprintk'
arch/i386/kernel/built-in.o(.init.text+0x46c9): undefined reference to `Dprintk'
arch/i386/kernel/built-in.o(.init.text+0x46dc): undefined reference to `Dprintk'
arch/i386/kernel/built-in.o(.init.text+0x46ef): undefined reference to `Dprintk'
arch/i386/kernel/built-in.o(.init.text+0x4702): more undefined references to
`Dprintk' follow
make: *** [vmlinux] Error 1
...

Why?



-- 
bye.
Andrey Nekrasov, SpyLOG.
