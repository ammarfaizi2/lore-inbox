Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUBJRPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUBJRNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:13:36 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:4109 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266058AbUBJRL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:11:58 -0500
Date: Tue, 10 Feb 2004 17:11:55 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Olaf Hering <olh@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ieee1394 and fbdev oops in 2.6.3rc2
In-Reply-To: <20040210165202.GA7590@suse.de>
Message-ID: <Pine.LNX.4.44.0402101708450.6294-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Oops: Exception in kernel mode, sig: 4 [#2]
> NIP: C0101000 LR: C0100F90 SP: EF185CF0 REGS: ef185c40 TRAP: 0700    Not tainted
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = ef1938a0[4325] 'X' Last syscall: 54 
> GPR00: 00000002 EF185CF0 EF1938A0 EFFA3C00 EF185CF8 00000000 EF185D94 00000000 
> GPR08: 00000000 FFFFFF00 00000001 00000000 28004884 101E6A58 101EEE08 101EED88 
> GPR16: 101EF108 101EEF88 101EEE08 7FFFF438 101ECCF8 101E0000 101E0000 101E0000 
> GPR24: 00000001 C02EBA40 000000A0 00000040 00000400 00000010 EFFA3C00 00000008 
> Call trace:
>  [<c01011ac>] fbcon_switch+0x11c/0x288
>  [<c00c56c4>] redraw_screen+0x1c0/0x22c
>  [<c00c027c>] complete_change_console+0x44/0xf8
>  [<c00bfa34>] vt_ioctl+0x16c0/0x1d60
>  [<c00b8604>] tty_ioctl+0x160/0x5d4
>  [<c006c51c>] sys_ioctl+0xdc/0x2fc
>  [<c0007c7c>] ret_from_syscall+0x0/0x44

This is very strange. No patches have gone in that affects fbcon_switch. 
Which kernel are you using and is this error repeatable?


