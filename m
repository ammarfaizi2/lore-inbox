Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTHJLHX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTHJLHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:07:23 -0400
Received: from fep02.swip.net ([130.244.199.130]:39339 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S262577AbTHJLHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:07:19 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 can't compile
Date: Sun, 10 Aug 2003 13:07:13 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308101307.13600.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried compile 2.6.0-test3, but I got this error messages:
gcc-3.3, Debian Woody with bunk debs

arch/i386/kernel/built-in.o(.data+0x14d4): In function `do_suspend_lowlevel':
: undefined reference to `save_processor_state'
arch/i386/kernel/built-in.o(.data+0x14da): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x14df): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x14e5): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x14eb): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x14f1): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x14f7): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x14fd): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1503): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x150a): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eflags'
arch/i386/kernel/built-in.o(.data+0x154a): In function `ret_point':
: undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x1550): In function `ret_point':
: undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x1555): In function `ret_point':
: undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x155b): In function `ret_point':
: undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x1561): In function `ret_point':
: undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1567): In function `ret_point':
: undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x156d): In function `ret_point':
: undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1573): In function `ret_point':
: undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x1578): In function `ret_point':
: undefined reference to `restore_processor_state'
arch/i386/kernel/built-in.o(.data+0x157e): In function `ret_point':
: undefined reference to `saved_context_eflags'
arch/i386/kernel/built-in.o(.data+0x158c): In function 
`do_suspend_lowlevel_s4bios':
: undefined reference to `save_processor_state'
arch/i386/kernel/built-in.o(.data+0x1592): In function 
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x1597): In function 
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x159d): In function 
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x15a3): In function 
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x15a9): In function 
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x15af): In function 
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x15b5): In function 
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x15bb): In function 
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x15c2): In function 
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_eflags'
arch/i386/mm/built-in.o(.init.text+0x4bf): In function `mem_init':
: undefined reference to `kclist_add'
arch/i386/mm/built-in.o(.init.text+0x4ec): In function `mem_init':
: undefined reference to `kclist_add'
drivers/built-in.o(.text+0x1a2dc): In function `acpi_suspend':
: undefined reference to `pm_prepare_console'
drivers/built-in.o(.text+0x1a345): In function `acpi_suspend':
: undefined reference to `pm_restore_console'
make: *** [.tmp_vmlinux1] Error 1

Michal

