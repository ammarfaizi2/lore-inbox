Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbTBLDzu>; Tue, 11 Feb 2003 22:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTBLDzt>; Tue, 11 Feb 2003 22:55:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:27567 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266384AbTBLDzr>;
	Tue, 11 Feb 2003 22:55:47 -0500
Message-ID: <32883.4.64.238.61.1045022735.squirrel@www.osdl.org>
Date: Tue, 11 Feb 2003 20:05:35 -0800 (PST)
Subject: Re: 2.5.60 atkbd oops
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <klinej@msoe.edu>
In-Reply-To: <1045021815.590.3.camel@tranquility>
References: <1045021815.590.3.camel@tranquility>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Running a Compaq Armada E500 (PIII 850, 256MB Ram), and 2.5.Feb 11 21:35:45
> tranquility kernel: [ACPI Debug] String: _L09:  Exit
> Feb 11 21:35:45 tranquility kernel:  printing eip:
> Feb 11 21:35:45 tranquility kernel: c021b209
> Feb 11 21:35:45 tranquility kernel: Oops: 0000
> Feb 11 21:35:45 tranquility kernel: CPU:    0
> Feb 11 21:35:45 tranquility kernel: EIP:    0060:[<c021b209>]    Not tainted
> Feb 11 21:35:45 tranquility kernel: EFLAGS: 00010246
> Feb 11 21:35:45 tranquility kernel: eax: 00000000   ebx: 8172d550   ecx:
> 00000000   edx: 00000006
> Feb 11 21:35:45 tranquility kernel: esi: 8172d550   edi: c12bbda8   ebp:
> c12bbd50   esp: c12bbd4c
> Feb 11 21:35:45 tranquility kernel: ds: 007b   es: 007b   ss: 0068 Feb 11
> 21:35:45 tranquility kernel: Process events/0 (pid: 3,
> threadinfo=c12ba000 task=c12bec40)
> Feb 11 21:35:45 tranquility kernel: Stack: c12bbd7c c12bbd68 c0219d27
> 8172d550 c12bbd7c c12bbda8 8172d550 c12bbd98
> Feb 11 21:35:45 tranquility kernel:        c022a3aa 8172d550 c0236bba
> c12bbda8 00010000 c04064ad c04064a4 0000005e
> Feb 11 21:35:45 tranquility kernel:        c12bbdac c12bbdac 8172d550
> c12bbdc8 c023061a 8172d550 c12bbda8 00000000
> Feb 11 21:35:45 tranquility kernel: Call Trace: [<c0219d27>]
> [<c022a3aa>]  [<c0236bba>]  [<c023061a>]  [<c02265fa>]  [<c02309ee>]
> [<c0230d
> 48>]  [<c022a760>]  [<c0226500>]  [<c02340c5>]  [<c023443e>]
> [<c02352b3>]  [<c020c2da>]  [<c0204895>]  [<c01370b5>]  [<c020485b>]
> [<c0136c
> e8>]  [<c0124b10>]  [<c0124b10>]  [<c0136ad0>]  [<c010825d>]
> Feb 11 21:35:45 tranquility kernel: Code: 80 3b aa 0f 44 c3 5b 5d c3 a1 b4
> 74 4c c0 eb f6 55 89 e5 8b
> Feb 11 21:36:00 tranquility kernel:  <4>atkbd.c: Unknown key (set 2,
> scancode 0x154, on isa0060/serio0) released.
> Feb 11 21:39:28 tranquility syslogd 1.4.1#11: restart.
> Feb 11 21:39:28 tranquility kernel: klogd 1.4.1#11, log source =
> /proc/kmsg started.
> Feb 11 21:39:28 tranquility kernel: Cannot find map file.
> Feb 11 21:39:28 tranquility kernel: No module symbols loaded - kernel
> modules not enabled.
> Feb 11 21:39:28 tranquility kernel: Linux version 2.5.60
> (klinej@tranquility) (gcc version 3.2.2) #0 Mon Feb 10 16:52:23 CST 2003 Feb
> 11 21:39:28 tranquility kernel: Video mode to be used for restore is f00
> Feb 11 21:39:28 tranquility kernel: BIOS-provided physical RAM map: 60, this
> oops occurs at moderately random intervals, mainly in X, while switching
> windows/screens. WM is blackbox, w/ bbkeys and bbpager.
> Keyboard becomes unuseable. Complete kernel config available if needed, as
> well as stack traces and possibly a rebote stack dump.

Hi,

Please decode that oops with ksymoops or use
CONFIG_KALLSYMS=y in your kernel config.

~Randy



