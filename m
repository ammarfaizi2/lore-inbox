Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314330AbSESLYU>; Sun, 19 May 2002 07:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314339AbSESLYT>; Sun, 19 May 2002 07:24:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15884 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314330AbSESLYS>; Sun, 19 May 2002 07:24:18 -0400
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Sun, 19 May 2002 12:44:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <E179IA6-0002eQ-00@wagner.rustcorp.com.au> from "Rusty Russell" at May 19, 2002 02:18:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179P70-0003dg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at 2.4.1x which has the same signal code

> arch/i386/kernel/signal.c:37:		return __copy_to_user(to, from, sizeof(siginfo_t));

not a bug
> arch/sparc/kernel/signal.c:101:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/alpha/kernel/signal.c:44:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/mips/kernel/signal.c:45:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/ppc/kernel/signal.c:70:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/m68k/kernel/signal.c:198:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/sparc64/kernel/signal.c:49:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/arm/kernel/signal.c:62:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/sh/kernel/signal.c:42:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/ia64/kernel/signal.c:147:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/mips64/kernel/signal.c:45:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/s390/kernel/signal.c:57:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/cris/kernel/signal.c:51:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/cris/kernel/signal.c:51:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

> arch/x86_64/kernel/signal.c:47:		return __copy_to_user(to, from, sizeof(siginfo_t));

Not a bug

