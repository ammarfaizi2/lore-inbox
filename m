Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSKOEH7>; Thu, 14 Nov 2002 23:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbSKOEH7>; Thu, 14 Nov 2002 23:07:59 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:34209 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S265725AbSKOEH6>;
	Thu, 14 Nov 2002 23:07:58 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.27-ac[1234] compile error
From: alexh@ihatent.com
Date: 15 Nov 2002 05:14:48 +0100
Message-ID: <87d6p7piyv.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/built-in.o
--start-group usr/built-in.o arch/i386/kernel/built-in.o
arch/i386/mm/built-in.o arch/i386/mach-generic/built-in.o
kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o
security/built-in.o crypto/built-in.o drivers/built-in.o
sound/built-in.o arch/i386/pci/built-in.o net/built-in.o lib/lib.a
arch/i386/lib/lib.a --end-group -o .tmp_vmlinux1
drivers/built-in.o: In function `pcmcia_get_first_tuple':
drivers/built-in.o(.text+0x7c488): undefined reference to`pcibios_read_config_dword'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [vmlinux] Error 2
alexh@lapper ~/src/linux/linux-2.5-test $

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
