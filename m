Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUGPWm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUGPWm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 18:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266640AbUGPWm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 18:42:56 -0400
Received: from AOrleans-204-1-24-180.w81-250.abo.wanadoo.fr ([81.250.166.180]:64773
	"EHLO lithium.mdsoft.net") by vger.kernel.org with ESMTP
	id S266627AbUGPWmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 18:42:47 -0400
From: KheOps <kheops@lithium.mdsoft.net>
Organization: MDSoft.net
To: linux-kernel@vger.kernel.org
Subject: bug submission
Date: Sat, 17 Jul 2004 00:42:58 +0200
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407170042.58876.kheops@lithium.mdsoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello
I tried to compile kernel 2.6.7 on an AMD Duron 800MHz, with gcc 2.95.3, GNU 
bash version 2.04.12(1), and here is what I get (after having configured 
properly the kernel for my system):

#make
(same lines since   HOSTCC  scripts/basic/fixdep)


  HOSTCC  scripts/kallsyms
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      scripts/empty.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  HOSTCC  scripts/mk_elfconfig
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  MKELF   scripts/elfconfig.h
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  HOSTCC  scripts/file2alias.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  HOSTCC  scripts/modpost.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  HOSTCC  scripts/sumversion.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  HOSTLD  scripts/modpost
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  HOSTCC  scripts/pnmtologo
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  HOSTCC  scripts/bin2c
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/asm-offsets.s
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CHK     include/asm-i386/asm_offsets.h
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  UPD     include/asm-i386/asm_offsets.h
  CC      init/main.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CHK     include/linux/compile.h
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
/usr/src/linux-2.6.7/scripts/mkcompile_h: invalid character 46 in exportstr 
for AFLAGS_vmlinux.lds.o
  UPD     include/linux/compile.h
  CC      init/version.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      init/do_mounts.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      init/mounts.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      init/initramfs.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      init/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  HOSTCC  usr/gen_init_cpio
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CPIO    usr/initramfs_data.cpio
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  GZIP    usr/initramfs_data.cpio.gz
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  AS      usr/initramfs_data.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      usr/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/process.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/semaphore.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/signal.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  AS      arch/i386/kernel/entry.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/traps.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/irq.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
{entrée standard}: Messages de l'assembleur:
{entrée standard}:1764: AVERTISSEMENT:initialisation incorrecte du type de 
section pour .bss.page_aligned
  CC      arch/i386/kernel/vm86.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/ptrace.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
(...)
  CC      arch/i386/kernel/acpi/boot.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/acpi/sleep.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  AS      arch/i386/kernel/acpi/wakeup.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      arch/i386/kernel/acpi/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
(...)
  CC      arch/i386/kernel/cpu/mcheck/winchip.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/cpu/mcheck/non-fatal.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      arch/i386/kernel/cpu/mcheck/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/cpu/mtrr/main.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
(...)
  CC      arch/i386/kernel/cpu/mtrr/centaur.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      arch/i386/kernel/cpu/mtrr/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      arch/i386/kernel/cpu/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/timers/timer.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
(...)
  CC      arch/i386/kernel/timers/common.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      arch/i386/kernel/timers/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/reboot.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
(...)
  CC      arch/i386/kernel/sysenter.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  AS      arch/i386/kernel/vsyscall-int80.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  SYSCALL arch/i386/kernel/vsyscall-int80.so
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  AS      arch/i386/kernel/vsyscall-sysenter.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  SYSCALL arch/i386/kernel/vsyscall-sysenter.so
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  AS      arch/i386/kernel/vsyscall.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/early_printk.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/std_resources.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  SYSCALL arch/i386/kernel/vsyscall-syms.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      arch/i386/kernel/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  AS      arch/i386/kernel/head.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/kernel/init_task.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CPP     arch/i386/kernel/vmlinux.lds.s
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/mm/init.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
(...)
  CC      arch/i386/mm/pageattr.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      arch/i386/mm/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/mach-default/setup.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      arch/i386/mach-default/topology.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      arch/i386/mach-default/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      kernel/sched.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      kernel/fork.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      kernel/exec_domain.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
(...)
  CC      kernel/power/process.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      kernel/power/console.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      kernel/power/pm.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      kernel/power/swsusp.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      kernel/power/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      kernel/acct.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  IKCFG   kernel/ikconfig.h
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
scripts/mkconfigs: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  GZIP    kernel/config_data.gz
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  IKCFG   kernel/config_data.h
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      kernel/configs.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      kernel/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      mm/bootmem.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
(...)
  CC      mm/swapfile.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  LD      mm/built-in.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      fs/open.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
(...)
  CC      fs/ioctl.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
  CC      fs/readdir.o
/bin/sh: invalid character 46 in exportstr for AFLAGS_vmlinux.lds.o
fs/readdir.c: In function `filldir64':
fs/readdir.c:259: internal error--unrecognizable insn:
(insn 184 183 451 (set (reg/v:SI 4 %esi)
        (asm_operands/v ("1:    movl %%eax,0(%2)
2:              movl %%edx,4(%2)
3:
.section .fixup,"ax"
4:              movl %3,%0
                jmp 3b
.previous
.section __ex_table,"a"
                .align 4
                .long 1b,4b
                .long 2b,4b
.previous") ("=r") 0[
                (reg:DI 1 %edx)
                (reg:SI 0 %eax)
                (const_int -14 [0xfffffff2])
                (reg/v:SI 4 %esi)
            ]
            [
                (asm_input:DI ("A"))
                (asm_input:SI ("r"))
                (asm_input:SI ("i"))
                (asm_input:SI ("0"))
            ]  ("fs/readdir.c") 241)) -1 (insn_list 181 (insn_list 183 (nil)))
    (nil))
make[1]: *** [fs/readdir.o] Erreur 1
make: *** [fs] Erreur 2

So it seems that there is something wrong with bash, but the big problem comes 
from the compilation of fs/readdir.c. I don't know what could cause that.
I hope this will help you a little bit to solve the problem.

Thank you
Kheops
