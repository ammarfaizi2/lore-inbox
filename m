Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318314AbSGYDbG>; Wed, 24 Jul 2002 23:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318316AbSGYDbG>; Wed, 24 Jul 2002 23:31:06 -0400
Received: from smtprelay8.dc2.adelphia.net ([64.8.50.40]:44475 "EHLO
	smtprelay8.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S318314AbSGYDbG>; Wed, 24 Jul 2002 23:31:06 -0400
Message-ID: <00a501c2338c$25365170$6a01a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com>
Subject: Linux-2.5.28 link problem
Date: Wed, 24 Jul 2002 23:34:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...need help getting a compile to complete.  This problem exists with
2.5.27-28.
Here's the last lines from make...

  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o
arch/i386/kernel/init
_task.o init/init.o --start-group arch/i386/kernel/kernel.o
arch/i386/mm/mm.o kernel/kernel.o mm
/mm.o fs/fs.o ipc/ipc.o security/built-in.o
/usr/src/v2.5.28/arch/i386/lib/lib.a lib/lib.a /usr/
src/v2.5.28/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o
arch/i386/pci/pci.o net/network
.o --end-group -o vmlinux
drivers/built-in.o: In function `md_run_setup':
/usr/src/v2.5.28/drivers/md/md.c(.data+0xee34): undefined reference to
`local symbols in discard
ed section .text.exit'
make: *** [vmlinux] Error 1

All the programs are better than specified in "Changes"...
    Gcc = 2.96-110 (RH7.3)
    binutils: ld = 2.11

thanks in advance, jeff

