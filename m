Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbSKPIdg>; Sat, 16 Nov 2002 03:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbSKPIdf>; Sat, 16 Nov 2002 03:33:35 -0500
Received: from ulima.unil.ch ([130.223.144.143]:7816 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S267244AbSKPIdf>;
	Sat, 16 Nov 2002 03:33:35 -0500
Date: Sat, 16 Nov 2002 09:40:31 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47-ac5:undefined reference to `boot_gdt_table'
Message-ID: <20021116084031.GA19556@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I can't compil it:

  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o  lib/lib.a  arch/i386/lib/lib.a --end-group  -o .tmp_vmlinux1
arch/i386/kernel/built-in.o(.data+0x15a5): In function `gdt_48':
: undefined reference to `boot_gdt_table'
make: *** [.tmp_vmlinux1] Error 1

Should I provide other infos?
Sorry if that was already reported and I didn't notice it...

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
