Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSJKKww>; Fri, 11 Oct 2002 06:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSJKKww>; Fri, 11 Oct 2002 06:52:52 -0400
Received: from cpe.atm0-0-0-209183.0x3ef29767.boanxx7.customer.tele.dk ([62.242.151.103]:2128
	"HELO mail.hswn.dk") by vger.kernel.org with SMTP
	id <S262394AbSJKKww>; Fri, 11 Oct 2002 06:52:52 -0400
Date: 11 Oct 2002 10:58:35 -0000
Message-ID: <20021011105835.12829.qmail@osiris.hswn.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41-mm3
References: <3DA699AA.BBA05716@digeo.com>
From: Henrik Storner <henrik@hswn.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.41/2.5.41-mm3/

Won't build:
In file included from arch/i386/kernel/timers/timer_pit.c:14:
arch/i386/mach-generic/do_timer.h: In function `do_timer_interrupt_hook':
arch/i386/mach-generic/do_timer.h:25: `using_apic_timer' undeclared (first use in this function)
arch/i386/mach-generic/do_timer.h:25: (Each undeclared identifier is reported only once
arch/i386/mach-generic/do_timer.h:25: for each function it appears in.)
arch/i386/mach-generic/do_timer.h:26: warning: implicit declaration of function `smp_local_timer_interrupt'
make[2]: *** [arch/i386/kernel/timers/timer_pit.o] Error 1

UP config with IO APIC enabled.
