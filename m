Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbTBSWNn>; Wed, 19 Feb 2003 17:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTBSWNn>; Wed, 19 Feb 2003 17:13:43 -0500
Received: from pipgate.pipsworld.sara.nl ([145.100.9.18]:33408 "EHLO
	dinkie.pipsworld.sara.nl") by vger.kernel.org with ESMTP
	id <S261996AbTBSWNm>; Wed, 19 Feb 2003 17:13:42 -0500
Date: Wed, 19 Feb 2003 23:23:44 +0100
From: Remco Post <r.post@sara.nl>
To: Remco Post <r.post@sara.nl>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux v2.5.62
Message-Id: <20030219232344.1b9f4c20.r.post@sara.nl>
In-Reply-To: <20030219224627.71a85963.r.post@sara.nl>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
	<3E536237.8010502@blue-labs.org>
	<20030219185017.GA6091@gemtek.lt>
	<20030219224627.71a85963.r.post@sara.nl>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003 22:46:27 +0100
Remco Post <r.post@sara.nl> wrote:

> Hi all,
> 
> just to let you all know, The linus 2.5.62 (plain as can be) just booted
> on my motorola powerstack II system. No modules, but also, no oops on
> boot, like 2.5.59 and allmost every other 2.5 before that....
> 
> -- Remco
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

and fortunately, I also have some use for booting this kernel:

When the ethernet link goed down on my on-board dec-tulip:

eth1: timeout expired stopping DMA                                              
kernel BUG at drivers/net/tulip/de2104x.c:925!                                  
Oops: Exception in kernel mode, sig: 4                                          
NIP: C0138248 LR: C0138248 SP: C0275E00 REGS: c0275d50 TRAP: 0700    
Not taintedMSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11                                 
TASK = c022f550[0] 'swapper' Last syscall: 120                                  
GPR00: C0138248 C0275E00 C022F550 0000002F 00000001 C0275CB8 C0271800 C02B0000  
GPR08: 0000161F 00000000 00000000 C0275D30 4000C088 00000000 00000000 00000000  
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000  
GPR24: 00000000 00000000 00000002 00001032 C03DD000 00009032 FFFFFFCE C03DD1C0  
Call trace: [c0138588]  [c002066c]  [c001b85c]  [c0007e80]  [c00061c4]  [c00039 
Kernel panic: Aiee, killing interrupt handler!                                  
In interrupt handler - not syncing                                             

Only after some traffic was supposed to leave the machine, not that it ever does 
with this kernel....


-- Remco
