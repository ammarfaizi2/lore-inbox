Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSLFOsg>; Fri, 6 Dec 2002 09:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSLFOsg>; Fri, 6 Dec 2002 09:48:36 -0500
Received: from perl6.de ([62.141.33.238]:23738 "EHLO
	silo.imperial-resistance.de") by vger.kernel.org with ESMTP
	id <S262876AbSLFOsc>; Fri, 6 Dec 2002 09:48:32 -0500
Message-ID: <45154.::ffff:195.36.75.26.1039187671.squirrel@silo.imperial-resistance.de>
Date: Fri, 6 Dec 2002 16:14:31 +0100 (CET)
Subject: [Fwd: [2.5.50]BUILD ERROR drivers/built-in.o]
From: "Christian Setzer" <baum@imperial-resistance.de>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF0BA33.AA0D4F01@partner.bmw.de>
References: <3DF0BA33.AA0D4F01@partner.bmw.de>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: baum@imperial-resistance.de
X-Mailer: SquirrelMail (version 1.3.1 [DEVEL])
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20021206161431_12672"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20021206161431_12672
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


 gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=pentium4
-Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o
init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/do_mounts.o init/initramfs.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o
arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o
net/built-in.o --end-group  -o .tmp_vmlinux1
drivers/built-in.o: In function `kd_nosound':
drivers/built-in.o(.text+0x177d6): undefined reference to `input_event'
drivers/built-in.o(.text+0x177f8): undefined reference to `input_event'
drivers/built-in.o: In function `kd_mksound':
drivers/built-in.o(.text+0x17897): undefined reference to `input_event'
drivers/built-in.o: In function `kbd_bh':
drivers/built-in.o(.text+0x185f3): undefined reference to `input_event'
drivers/built-in.o(.text+0x18616): undefined reference to `input_event'
drivers/built-in.o(.text+0x18635): more undefined references to
`input_event' follow
drivers/built-in.o: In function `kbd_connect':
drivers/built-in.o(.text+0x18b8f): undefined reference to
`input_open_device'
drivers/built-in.o: In function `kbd_disconnect':
drivers/built-in.o(.text+0x18bbb): undefined reference to
`input_close_device'
drivers/built-in.o: In function `kbd_init':
drivers/built-in.o(.init.text+0x119b): undefined reference to
`input_register_handler'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [vmlinux] Error 2



------=_20021206161431_12672
Content-Type: text/x-vcard; name="christian.setzer.vcf"
Content-Disposition: attachment; filename="christian.setzer.vcf"

begin:vcard 
n:Setzer;Christian
tel;work:089 382-41158
x-mozilla-html:FALSE
adr:;;;;;;
version:2.1
email;internet:Christian.Setzer@partner.bmw.de
x-mozilla-cpt:;20000
fn:Christian Setzer
end:vcard


------=_20021206161431_12672--

