Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265577AbSKADyD>; Thu, 31 Oct 2002 22:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265580AbSKADyC>; Thu, 31 Oct 2002 22:54:02 -0500
Received: from ns.miraclelinux.com ([219.101.34.26]:35066 "EHLO
	dns01.miraclelinux.com") by vger.kernel.org with ESMTP
	id <S265577AbSKADyC>; Thu, 31 Oct 2002 22:54:02 -0500
To: linux-kernel@vger.kernel.org
Cc: hyoshiok@miraclelinux.com
Subject: build error in 2.5.45
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20021101125652G.hyoshiok@miraclelinux.com>
Date: Fri, 01 Nov 2002 12:56:52 +0900
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
net/built-in.o: In function `p8022_request':
net/built-in.o(.text+0xf4b9): undefined reference to `llc_build_and_send_ui_pkt'
net/built-in.o: In function `register_8022_client':
net/built-in.o(.text+0xf502): undefined reference to `llc_sap_open'
net/built-in.o: In function `unregister_8022_client':
net/built-in.o(.text+0xf52e): undefined reference to `llc_sap_close'
net/built-in.o: In function `snap_request':
net/built-in.o(.text+0xf663): undefined reference to `llc_build_and_send_ui_pkt'
net/built-in.o: In function `snap_init':
net/built-in.o(.init.text+0x613): undefined reference to `llc_sap_open'
make: *** [.tmp_vmlinux1] Error 1

Thanks in advance,
  Hiro
