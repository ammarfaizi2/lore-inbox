Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTESMWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 08:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTESMWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 08:22:00 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:19929 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262434AbTESMV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 08:21:59 -0400
Date: Mon, 19 May 2003 14:34:53 +0200 (MEST)
Message-Id: <200305191234.h4JCYrCD016942@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: gj@pointblue.com.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk13 compilation error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 May 2003 12:10:48 +0100, Grzegorz Jaskiewicz wrote:
>make bzImage modules gives me this. config atached.
>
>     ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
>arch/i386/kernel/init_task.o   init/built-in.o --start-group 
>usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
>arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o 
>fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o 
>lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
>arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
>arch/i386/kernel/built-in.o(.data+0x137a): In function
>`do_suspend_lowlevel':
>: undefined reference to `saved_context_esp'

A patch for this was posted last week. Search the LKML archives.
