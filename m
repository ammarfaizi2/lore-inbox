Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbSKBBxW>; Fri, 1 Nov 2002 20:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265858AbSKBBxW>; Fri, 1 Nov 2002 20:53:22 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:15044 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265857AbSKBBxW> convert rfc822-to-8bit; Fri, 1 Nov 2002 20:53:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCH] Linux-2.5.45-mcp1
Date: Sat, 2 Nov 2002 02:48:44 +0100
User-Agent: KMail/1.4.3
Cc: Paul <set@pobox.com>
References: <200210031903.16106.m.c.p@wolk-project.de> <20021102014200.GI7170@squish.home.loc>
In-Reply-To: <20021102014200.GI7170@squish.home.loc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211020248.44889.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 November 2002 02:42, Paul wrote:

Hi Paul,

> 	        ld -m elf_i386 -e stext -T
> arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
> arch/i386/kernel/init_task.o  init/built-in.o --start-group
> arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
> arch/i386/mach-generic/built-in.o  kernel/built-in.o
> mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o
> crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a
> drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o
> net/built-in.o --end-group  -o vmlinux
> mm/built-in.o(.kstrtab+0x160): multiple definition of
> `__kstrtab_page_states__per_cpu'
> kernel/built-in.o(.kstrtab+0xb40): first defined here
> mm/built-in.o(__ksymtab+0x48): multiple definition of
> `__ksymtab_page_states__per_cpu'
> kernel/built-in.o(__ksymtab+0x330): first defined here
> make: *** [vmlinux] Error 1

First, thnx for reporting :-)

Please use 2.5.45-mcp2 announced some minutes ago. Should work!

ciao, Marc


