Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbSKMQkn>; Wed, 13 Nov 2002 11:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262248AbSKMQkn>; Wed, 13 Nov 2002 11:40:43 -0500
Received: from suonpaa.iki.fi ([62.236.96.196]:54700 "EHLO
	oberon.erasmus.jurri.net") by vger.kernel.org with ESMTP
	id <S262244AbSKMQkm>; Wed, 13 Nov 2002 11:40:42 -0500
To: Paul <set@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.47-ac2
References: <200211130130.gAD1U0B10849@devserv.devel.redhat.com>
	<20021113031047.GP9928@squish.home.loc>
From: Samuli Suonpaa <suonpaa@iki.fi>
Date: Wed, 13 Nov 2002 18:46:44 +0200
In-Reply-To: <20021113031047.GP9928@squish.home.loc> (Paul's message of
 "Tue, 12 Nov 2002 22:10:47 -0500")
Message-ID: <87smy5ifij.fsf@puck.erasmus.jurri.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul <set@pobox.com> writes:
> Alan Cox <alan@redhat.com>, on Tue Nov 12, 2002 [08:30:00 PM] said:
>> Linux 2.5.47-ac2
>         ld -m elf_i386 -e stext -T
> arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
> arch/i386/kernel/init_task.o  init/built-in.o --start-group
> usr/built-in.o  arch/i386/kernel/built-in.o
> arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o
> kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
> security/built-in.o  crypto/built-in.o  drivers/built-in.o
> sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o
> lib/lib.a  arch/i386/lib/lib.a --end-group  -o vmlinux
> arch/i386/kernel/built-in.o: In function `gdt_48':
> arch/i386/kernel/built-in.o(.data+0xf05): undefined reference to
> `boot_gdt_table'
> make: *** [vmlinux] Error 1

I get this also. With every 4.5-kernel I have tried compiling. (At
least 4.5.45, 4.5.45-ac2, 4.5.47-ac1.) It has something to do with
Local IO-APIC, since turning it of gets rid of the error.

Suonp‰‰...
