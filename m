Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbSJAPMB>; Tue, 1 Oct 2002 11:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261694AbSJAPMB>; Tue, 1 Oct 2002 11:12:01 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:45029 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261692AbSJAPMA>; Tue, 1 Oct 2002 11:12:00 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40: undefined reference to `errno'
Date: Tue, 1 Oct 2002 16:52:21 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210011652.21954.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux
init/built-in.o: In function `init':
init/built-in.o(.text+0xf1): undefined reference to `errno'
init/built-in.o(.text+0x124): undefined reference to `errno'
init/built-in.o(.text+0x136): undefined reference to `errno'
init/built-in.o(.text+0x163): undefined reference to `errno'
init/built-in.o(.text+0x17d): undefined reference to `errno'
init/built-in.o(.text+0x192): more undefined references to `errno' follow
make[1]: *** [.tmp_vmlinux] Error 1
