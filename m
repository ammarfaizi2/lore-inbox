Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUAFCIU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 21:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUAFCIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 21:08:20 -0500
Received: from [211.167.76.68] ([211.167.76.68]:11440 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S265248AbUAFCIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 21:08:19 -0500
Date: Tue, 6 Jan 2004 09:43:50 +0800
From: Hugang <hugang@soulinfo.com>
To: Hugang <hugang@soulinfo.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Bastiaan Spandaw <lkml@becobaf.com>,
       Tomas Szepe <szepe@pinerecords.com>, Max Valdez <maxvalde@fis.unam.mx>
Subject: Re: 2.6.1-rc1 affected?
Message-Id: <20040106094350.4528f242@localhost>
In-Reply-To: <20040106093145.0fd0d4b5@localhost>
References: <1073351377.2690.1.camel@garaged.homeip.net>
	<Pine.LNX.4.56.0401060221170.7597@jju_lnx.backbone.dif.dk>
	<20040106093145.0fd0d4b5@localhost>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004 09:31:45 +0800
Hugang <hugang@soulinfo.com> wrote:

> do nothing in my laptop.
> 
> [hugang@:build]$ ./mremap_poc 
> Trace/breakpoint trap
> 
> powerpc G4, PowerBook G4, 2.6.0-test11-wli + laptop mode path

Sorry, My fault, it let my kernel oops.

kernel BUG in exit_mmap at mm/mmap.c:1468!
Oops: Exception in kernel mode, sig: 5 [#14]
NIP: C00490E0 LR: C00490B0 SP: C094DED0 REGS: c094de20 TRAP: 0700    Not tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1c83160[2783] 'mremap_poc' Last syscall: 1 
GPR00: 00000001 C094DED0 C1C83160 0000000A 00000000 0A89DFFC C01C6740 00009032 
GPR08: 0000AF9F C01F247C FFFFFFCB C01F0000 82000002 100187B8 00000000 100D7B78 
GPR16: 100D6BE8 10060000 10060000 00000000 00000000 100C8558 100D6BE8 00000000 
GPR24: 00000000 0FFE6BB0 0FFD9590 0FFD9590 00000000 00000000 C1C83160 C95384C0 
Call trace:
 [c0016914] mmput+0x7c/0xbc
 [c001a9e8] do_exit+0x19c/0x380
 [c001ac08] do_group_exit+0x0/0x98
 [c000602c] ret_from_syscall+0x0/0x4c


-- 
Hu Gang / Steve
RLU#          : 204016 [1999] (Registered Linux user)
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
