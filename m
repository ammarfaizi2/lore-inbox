Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263420AbTC2OKV>; Sat, 29 Mar 2003 09:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263421AbTC2OKV>; Sat, 29 Mar 2003 09:10:21 -0500
Received: from klesk.etc.utt.ro ([193.226.10.1]:5336 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id <S263420AbTC2OKU>;
	Sat, 29 Mar 2003 09:10:20 -0500
From: Sony Calin <sony@etc.utt.ro>
Message-ID: <44829.194.138.39.56.1048947941.squirrel@webmail.etc.utt.ro>
Date: Sat, 29 Mar 2003 16:25:41 +0200 (EET)
Subject: Compile error 2.5.66-mm1 (haven't tried with 2.5.66 vanilla)
To: <akpm@zip.com.au>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Compiling 2.5.66-mm1 gives me the following error

   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
arch/i386/kernel/init_task.o   init/built-in.o --start-group 
usr/built-in.o  arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
security/built-in.o  crypto/built-in.o  lib/lib.a 
arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o
.tmp_vmlinux1
sound/built-in.o: In function `cs4232_pnp_remove':
sound/built-in.o(.text+0xaf51): undefined reference to `local symbols in
discarded section .exit.text'
make: *** [.tmp_vmlinux1] Error 1

Program versions and config are atached.

Bye
Calin

-- 
# fortune
fortune: write error on /dev/null - please empty the bit bucket



-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


