Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265044AbSJRHUf>; Fri, 18 Oct 2002 03:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265045AbSJRHUf>; Fri, 18 Oct 2002 03:20:35 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:59800 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S265044AbSJRHUf>; Fri, 18 Oct 2002 03:20:35 -0400
From: "Laramie Leavitt" <laramie.leavitt@attbi.com>
To: <linux-kernel@vger.kernel.org>
Subject: Error compiling 2.5.43 Alpha.
Date: Fri, 18 Oct 2002 00:26:40 -0700
Message-ID: <OFEJKOGEKOCPKMCJDFCEKECGCAAA.laramie.leavitt@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I get the following error while attempting to compile 2.5.43 for Alpha.
Are there any recent 2.5 releases that work on dual alpha?  gcc is 2.95.4.



gcc -Wp,-MD,arch/alpha/kernel/.irq_alpha.o.d -D__KERNEL__ -Iinclude -Wall -W
strict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasi
ng -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -
iwithprefix include    -DKBUILD_BASENAME=irq_alpha   -c -o
arch/alpha/kernel/irq_alpha.o arch/alpha/kernel/irq_alpha.c
In file included from arch/alpha/kernel/irq_alpha.c:15:
arch/alpha/kernel/irq_impl.h: In function `alpha_do_profile':
arch/alpha/kernel/irq_impl.h:50: `prof_buffer' undeclared (first use in this
function)
arch/alpha/kernel/irq_impl.h:50: (Each undeclared identifier is reported
only once
arch/alpha/kernel/irq_impl.h:50: for each function it appears in.)
arch/alpha/kernel/irq_impl.h:61: `prof_shift' undeclared (first use in this
function)
arch/alpha/kernel/irq_impl.h:67: `prof_len' undeclared (first use in this
function)
make[1]: *** [arch/alpha/kernel/irq_alpha.o] Error 1

