Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318842AbSG0Wao>; Sat, 27 Jul 2002 18:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318846AbSG0Wao>; Sat, 27 Jul 2002 18:30:44 -0400
Received: from leviathan.kumin.ne.jp ([211.9.65.12]:11549 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S318842AbSG0Wan>; Sat, 27 Jul 2002 18:30:43 -0400
Message-Id: <200207272233.AA00105@prism.kumin.ne.jp>
Date: Sun, 28 Jul 2002 07:33:40 +0900
To: linux-kernel@vger.kernel.org
Subject: 2.5.29 Compile error
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
In-Reply-To: <200205060815.AA00092@prism.kumin.ne.jp>
References: <200205060815.AA00092@prism.kumin.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

linux-2.5.29 compile error occured.

===== make bzImage error log =====

softirq.c: In function `spawn_ksoftirqd':
softirq.c:416: warning: statement with no effect
buffer.c: In function `__buffer_error':
buffer.c:65: warning: implicit declaration of function `show_stack'
agp.h:86: warning: `global_cache_flush' defined but not used
agp.h:86: warning: `global_cache_flush' defined but not used
ide-cd.c: In function `ide_cdrom_do_request':
ide-cd.c:1623: warning: implicit declaration of function `ide_stall_queue'
eepro100.c:2248: warning: `eepro100_remove_one' defined but not used
share.c: In function `parport_claim_or_block':
share.c:1005: warning: unused variable `flags'
bluesmoke.c:309: warning: `mce_task' defined but not used
apm.c: In function `apm_get_info':
apm.c:1592: warning: implicit declaration of function `num_possible_cpus'
apm.c: At top level:
apm.c:933: warning: `sysrq_poweroff_op' defined but not used
arch/i386/kernel/kernel.o: In function `apm_get_info':
arch/i386/kernel/kernel.o(.text+0x903b): undefined reference to `num_possible_cpus'
arch/i386/kernel/kernel.o: In function `apm':
arch/i386/kernel/kernel.o(.text+0x9215): undefined reference to `num_possible_cpus'
arch/i386/kernel/kernel.o(.text+0x937a): undefined reference to `num_possible_cpus'
arch/i386/kernel/kernel.o: In function `apm_init':
arch/i386/kernel/kernel.o(.text.init+0x3b81): undefined reference to `num_possible_cpus'
arch/i386/kernel/kernel.o(.text.init+0x3d07): undefined reference to `num_possible_cpus'
make: *** [vmlinux] Error 1

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
