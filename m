Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263126AbSJBPiE>; Wed, 2 Oct 2002 11:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263129AbSJBPiE>; Wed, 2 Oct 2002 11:38:04 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:60204 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S263126AbSJBPiD>; Wed, 2 Oct 2002 11:38:03 -0400
Subject: 2.5.40 make bzImage fail
From: Bob Raymond <guarneri@mindspring.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Oct 2002 15:48:39 +0100
Message-Id: <1033570121.19910.1.camel@EPoX.Linux.Raymond>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No patches applied.

  Generating build number
make[1]: Entering directory `/usr/src/linux-2.5.40/init'
  Generating /usr/src/linux-2.5.40/include/linux/compile.h (not
modified)
make[1]: Leaving directory `/usr/src/linux-2.5.40/init'
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
--start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o
fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a 
arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
fs/built-in.o: In function `pagebuf_queue_task':
fs/built-in.o(.text+0xc9b93): undefined reference to `queue_task'
fs/built-in.o: In function `pagebuf_iodone':
fs/built-in.o(.text+0xc9c62): undefined reference to `queue_task'
fs/built-in.o: In function `pagebuf_iodone_daemon':
fs/built-in.o(.text+0xca722): undefined reference to `TQ_ACTIVE'
fs/built-in.o(.text+0xca74a): undefined reference to `run_task_queue'
make: *** [vmlinux] Error 1


Bob Raymond


