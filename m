Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273799AbRIRBnl>; Mon, 17 Sep 2001 21:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273800AbRIRBnc>; Mon, 17 Sep 2001 21:43:32 -0400
Received: from web10403.mail.yahoo.com ([216.136.130.95]:50180 "HELO
	web10403.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273799AbRIRBnY>; Mon, 17 Sep 2001 21:43:24 -0400
Message-ID: <20010918014348.17878.qmail@web10403.mail.yahoo.com>
Date: Tue, 18 Sep 2001 11:43:48 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: compile 2.4.10-pre11 error
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ld -m elf_i386 -T /home/linux/arch/i386/vmlinux.lds -e
stext arch/i386/kernel/head.o
arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o
drivers/media/media.o drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o
drivers/cdrom/driver.o drivers/pci/driver.o
drivers/video/video.o \
        net/network.o \
        /home/linux/arch/i386/lib/lib.a
/home/linux/lib/lib.a /home/linux/arch/i386/lib/lib.a
\
        --end-group \
        -o vmlinux
mm/mm.o: In function `kmem_cache_alloc':
mm/mm.o(.text+0x8ef2): undefined reference to
`__builtin_expect'
mm/mm.o(.text+0x8f0f): undefined reference to
`__builtin_expect'
mm/mm.o(.text+0x8f62): undefined reference to
`__builtin_expect'
mm/mm.o: In function `kmalloc':
mm/mm.o(.text+0x9022): undefined reference to
`__builtin_expect'
mm/mm.o(.text+0x903f): undefined reference to
`__builtin_expect'
mm/mm.o(.text+0x9092): more undefined references to
`__builtin_expect' follow
make: *** [vmlinux] Error 1

=====
S.KIEU

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
