Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264854AbSKVNhd>; Fri, 22 Nov 2002 08:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSKVNhd>; Fri, 22 Nov 2002 08:37:33 -0500
Received: from isis.telemach.net ([213.143.65.10]:262 "HELO isis.telemach.net")
	by vger.kernel.org with SMTP id <S264854AbSKVNhc>;
	Fri, 22 Nov 2002 08:37:32 -0500
Message-ID: <000701c29229$67be62c0$41448fd5@gregar759sjxvl>
From: "Grega Fajdiga" <Gregor.Fajdiga@telemach.net>
To: <linux-kernel@vger.kernel.org>
Subject: Compile error and warings with kernel version 2.5.48-bk4
Date: Fri, 22 Nov 2002 14:16:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

This is the list of compile errors and warnings I get, while
compiling version 2.5.48-bk4:

arch/i386/kernel/apm.c:336:1: warning: "savesegment" redefined
In file included from include/linux/elf.h:5,
                 from include/linux/module.h:17,
                 from arch/i386/kernel/apm.c:205:
include/asm/elf.h:63:1: warning: this is the location of the previous
definition
/tmp/ccryEe4h.s: Assembler messages:
/tmp/ccryEe4h.s:1363: Warning: using `%ax' instead of `%eax' due to `w'
suffix
mm/vmscan.c: In function `shrink_caches':
mm/vmscan.c:746: warning: duplicate `const'
mm/swap_state.c: In function `free_pages_and_swap_cache':
mm/swap_state.c:299: warning: duplicate `const'
drivers/base/base.h:38: warning: `class_hotplug' defined but not used
drivers/base/base.h:38: warning: `class_hotplug' defined but not used
drivers/base/base.h:38: warning: `class_hotplug' defined but not used
drivers/base/base.h:38: warning: `class_hotplug' defined but not used
drivers/base/base.h:38: warning: `class_hotplug' defined but not used
In file included from drivers/char/sysrq.c:30:
include/linux/suspend.h:76: warning: static declaration for
`software_suspend' follows non-static
drivers/char/agp/agp.h:87: warning: `global_cache_flush' defined but not
used
drivers/char/agp/agp.h:87: warning: `global_cache_flush' defined but not
used
drivers/serial/8250_pci.c:802: warning: `pci_remove_one' defined but not
used
net/ipv4/raw.c: In function `raw_get_next':
net/ipv4/raw.c:717: warning: deprecated use of label at end of compound
statement
net/ipv4/arp.c: In function `neigh_get_next':
net/ipv4/arp.c:1175: warning: deprecated use of label at end of compound
statement
arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
arch/i386/kernel/built-in.o(.data+0x15e4): undefined reference to
`save_processor_state'
arch/i386/kernel/built-in.o(.data+0x15ea): undefined reference to
`saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x15ef): undefined reference to
`saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x15f5): undefined reference to
`saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x15fb): undefined reference to
`saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1601): undefined reference to
`saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x1607): undefined reference to
`saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x160d): undefined reference to
`saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1613): undefined reference to
`saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x161a): undefined reference to
`saved_context_eflags'
arch/i386/kernel/built-in.o(.data+0x165a): undefined reference to
`saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x1660): undefined reference to
`saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x1665): undefined reference to
`saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x166b): undefined reference to
`saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x1671): undefined reference to
`saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1677): undefined reference to
`saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x167d): undefined reference to
`saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1683): undefined reference to
`saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x1688): undefined reference to
`restore_processor_state'
arch/i386/kernel/built-in.o(.data+0x168e): undefined reference to
`saved_context_eflags'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [vmlinux] Error 2

.config available upon request. Is my binutils too old?
This is Red Hat 8.0. Please CC me.

Best Regards,
Grega Fajdiga


