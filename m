Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262847AbSI3OXw>; Mon, 30 Sep 2002 10:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262849AbSI3OXw>; Mon, 30 Sep 2002 10:23:52 -0400
Received: from 62-190-216-133.pdu.pipex.net ([62.190.216.133]:3588 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262847AbSI3OXv>; Mon, 30 Sep 2002 10:23:51 -0400
Date: Mon, 30 Sep 2002 15:37:35 +0100
From: jbradford@dial.pipex.com
Message-Id: <200209301437.g8UEbY0r005753@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.39 compile failiure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using GCC 2.95.3

make[1]: Leaving directory `/usr/src/linux-2.5.39/init'
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/math-emu/built-in.o  net/built-in.o --end-group  -o vmlinux
arch/i386/kernel/built-in.o: In function `MP_processor_info':
arch/i386/kernel/built-in.o(.text.init+0x3531): undefined reference to `Dprintk'arch/i386/kernel/built-in.o(.text.init+0x3544): undefined reference to `Dprintk'arch/i386/kernel/built-in.o(.text.init+0x3557): undefined reference to `Dprintk'arch/i386/kernel/built-in.o(.text.init+0x356a): undefined reference to `Dprintk'arch/i386/kernel/built-in.o(.text.init+0x357d): undefined reference to `Dprintk'arch/i386/kernel/built-in.o(.text.init+0x3590): more undefined references to `Dprintk' follow
drivers/built-in.o: In function `__uart_register_port':
drivers/built-in.o(.text+0x2123): undefined reference to `uart_type'
drivers/built-in.o: In function `ide_setup':
drivers/built-in.o(.text.init+0x185a): undefined reference to `cmd640_vlb'
drivers/built-in.o: In function `probe_for_hwifs':
drivers/built-in.o(.text.init+0x1a21): undefined reference to `ide_probe_for_cmd640x'
make: *** [vmlinux] Error 1

John.
