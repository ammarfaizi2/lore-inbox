Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTFKRcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTFKRcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:32:19 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:57988
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S263305AbTFKRcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:32:15 -0400
From: "jds" <jds@soltis.cc>
To: linux-kernel@vger.kernel.org
Subject: problem when compile 2.5.70-mm8 
Date: Wed, 11 Jun 2003 11:16:43 -0600
Message-Id: <20030611171334.M36451@soltis.cc>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi:

   I try the compile kernel 2.5.70-mm8 and recive this messages:

      [root@toshiba linux-2.5.70]# make bzImage
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  Making asm->asm-i386 symlink
  CC      scripts/empty.o
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTLD  scripts/modpost
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/i386/kernel/asm-offsets.s
  CHK     include/asm-i386/asm_offsets.h
  UPD     include/asm-i386/asm_offsets.h
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_rd.o
  CC      init/do_mounts_initrd.o
  LD      init/mounts.o
  CC      init/initramfs.o
  LD      init/built-in.o
  HOSTCC  usr/gen_init_cpio
  CPIO    usr/initramfs_data.cpio
  GZIP    usr/initramfs_data.cpio.gz
  LD      usr/initramfs_data.o
  LD      usr/built-in.o
  CC      arch/i386/kernel/process.o
  CC      arch/i386/kernel/semaphore.o
  CC      arch/i386/kernel/signal.o
  AS      arch/i386/kernel/entry.o
  CC      arch/i386/kernel/traps.o
  CC      arch/i386/kernel/irq.o
  CC      arch/i386/kernel/vm86.o
  CC      arch/i386/kernel/ptrace.o
  CC      arch/i386/kernel/i8259.o
  CC      arch/i386/kernel/ioport.o
  CC      arch/i386/kernel/ldt.o
  CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c: In function `setup_early_printk':
arch/i386/kernel/setup.c:919: invalid lvalue in unary `&'
make[1]: *** [arch/i386/kernel/setup.o] Error 1
make: *** [arch/i386/kernel] Error 2

  Help me please;

  Regards.

