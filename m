Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbSKMMHo>; Wed, 13 Nov 2002 07:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbSKMMHn>; Wed, 13 Nov 2002 07:07:43 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:8370 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S267189AbSKMMHm>; Wed, 13 Nov 2002 07:07:42 -0500
Date: Wed, 13 Nov 2002 12:14:30 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
X-X-Sender: mb@jester.mews
To: Pawel Bernadowski <pbern@wilnet.info>
cc: Margit Schubert-While <margit@margit.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.47-ac2
In-Reply-To: <Pine.LNX.4.44L.0211131116510.26709-100000@farma.wilnet.info>
Message-ID: <Pine.LNX.4.44.0211131213470.1118-100000@jester.mews>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (18BwPf-0006rD-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:17 +0100 Pawel Bernadowski wrote:

>i have too... this error.

It builds (and runs nicely :) without local APIC support for me.

>  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall 
>-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
>-pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic 
>-Iarch/i386/mach-defaults -fomit-frame-pointer -nostdinc -iwithprefix 
>include    -DKBUILD_BASENAME=version   -c -o init/version.o init/version.c
>   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
>init/do_mounts.o init/initramfs.o
>        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
>arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o 
>--start-group  usr/built-in.o  arch/i386/kernel/built-in.o  
>arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  
>kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  
>security/built-in.o  crypto/built-in.o  drivers/built-in.o  
>sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o  lib/lib.a  
>arch/i386/lib/lib.a --end-group  -o .tmp_vmlinux1
>arch/i386/kernel/built-in.o: In function `gdt_48':
>arch/i386/kernel/built-in.o(.data+0x12b1): undefined reference to 
>`boot_gdt_table'


