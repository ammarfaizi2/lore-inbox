Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267108AbSKMDEA>; Tue, 12 Nov 2002 22:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267110AbSKMDEA>; Tue, 12 Nov 2002 22:04:00 -0500
Received: from mail.michigannet.com ([208.49.116.30]:32782 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S267108AbSKMDEA>; Tue, 12 Nov 2002 22:04:00 -0500
Date: Tue, 12 Nov 2002 22:10:47 -0500
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.47-ac2
Message-ID: <20021113031047.GP9928@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
References: <200211130130.gAD1U0B10849@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211130130.gAD1U0B10849@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com>, on Tue Nov 12, 2002 [08:30:00 PM] said:
> ** I strongly recommend saying N to IDE TCQ options otherwise this
>    should hopefully build and run happily.
> 
> This contains new IDE stuff. Exercise the usual caution.
> 
> Linux 2.5.47-ac2

	Hi;

        ld -m elf_i386 -e stext -T
arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
arch/i386/kernel/init_task.o  init/built-in.o --start-group
usr/built-in.o  arch/i386/kernel/built-in.o
arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
security/built-in.o  crypto/built-in.o  drivers/built-in.o
sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o
lib/lib.a  arch/i386/lib/lib.a --end-group  -o vmlinux
arch/i386/kernel/built-in.o: In function `gdt_48':
arch/i386/kernel/built-in.o(.data+0xf05): undefined reference to
`boot_gdt_table'
make: *** [vmlinux] Error 1

# CONFIG_SMP is not set

Paul
set@pobox.com
