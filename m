Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271250AbTGQLdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTGQLdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:33:36 -0400
Received: from lns-th2-5f-81-56-227-145.adsl.proxad.net ([81.56.227.145]:8838
	"EHLO smtp.ced-2.eu.org") by vger.kernel.org with ESMTP
	id S271250AbTGQLct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:32:49 -0400
Message-ID: <3F168CDB.8030906@ifrance.com>
Date: Thu, 17 Jul 2003 13:47:39 +0200
From: =?ISO-8859-1?Q?C=E9dric?= <cedriccsm2@ifrance.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: fr-fr, fr, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1-osdl2 : doesn't compile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to compile linux 2.6.0-test1-osdl2 but I cannot.

(my config compiles with linus' -test1)
(using gcc 3.2)

Log:

gmake[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
   CHK     include/linux/compile.h
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `kernel_thread':
arch/i386/kernel/built-in.o(.text+0x321): undefined reference to 
`trace_event'
arch/i386/kernel/built-in.o: In function `syscall_call':
arch/i386/kernel/built-in.o(.text+0x2549): undefined reference to 
`syscall_entry_trace_active'
arch/i386/kernel/built-in.o: In function `syscall_exit':
arch/i386/kernel/built-in.o(.text+0x256d): undefined reference to 
`syscall_exit_trace_active'
arch/i386/kernel/built-in.o: In function `trace_real_syscall_entry':
arch/i386/kernel/built-in.o(.text+0x35b6): undefined reference to 
`trace_event'
arch/i386/kernel/built-in.o(.text+0x35e8): undefined reference to 
`trace_get_config'
arch/i386/kernel/built-in.o: In function `trace_real_syscall_exit':
arch/i386/kernel/built-in.o(.text+0x3696): undefined reference to 
`trace_event'
arch/i386/kernel/built-in.o: In function `do_divide_error':
arch/i386/kernel/built-in.o(.text+0x37fd): undefined reference to 
`trace_event'
arch/i386/kernel/built-in.o(.text+0x3852): undefined reference to 
`trace_event'
arch/i386/kernel/built-in.o: In function `do_int3':
arch/i386/kernel/built-in.o(.text+0x38ed): undefined reference to 
`trace_event'
arch/i386/kernel/built-in.o(.text+0x3948): undefined reference to 
`trace_event'
arch/i386/kernel/built-in.o(.text+0x39dd): more undefined references to 
`trace_event' follow
arch/i386/kernel/built-in.o: In function `sys_call_table':
arch/i386/kernel/built-in.o(.data+0x7c4): undefined reference to `sys_trace'
arch/i386/mm/built-in.o: In function `do_page_fault':
arch/i386/mm/built-in.o(.text+0x517): undefined reference to `trace_event'
arch/i386/mm/built-in.o(.text+0x555): undefined reference to `trace_event'
kernel/built-in.o: In function `try_to_wake_up':
kernel/built-in.o(.text+0x1d1): undefined reference to `trace_event'
kernel/built-in.o: In function `schedule':
kernel/built-in.o(.text+0x1360): undefined reference to `trace_event'
kernel/built-in.o: In function `do_fork':
kernel/built-in.o(.text+0x57cf): undefined reference to `trace_event'
kernel/built-in.o: In function `do_exit':
kernel/built-in.o(.text+0x85b7): undefined reference to 
`trace_destroy_owners_events'
kernel/built-in.o(.text+0x85c1): undefined reference to 
`trace_free_all_handles'
kernel/built-in.o(.text+0x85d4): undefined reference to `trace_event'
kernel/built-in.o: In function `sys_wait4':
kernel/built-in.o(.text+0x90a4): undefined reference to `trace_event'
kernel/built-in.o: In function `it_real_fn':
kernel/built-in.o(.text+0x95e1): undefined reference to `trace_event'
kernel/built-in.o: In function `do_setitimer':
kernel/built-in.o(.text+0x9713): undefined reference to `trace_event'
kernel/built-in.o: In function `do_softirq':
kernel/built-in.o(.text+0xa430): undefined reference to `trace_event'
kernel/built-in.o(.text+0xa70c): more undefined references to 
`trace_event' follow
gmake: *** [.tmp_vmlinux1] Error 1

-- 
Cédric Barboiron

