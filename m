Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbTBXWBB>; Mon, 24 Feb 2003 17:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTBXWBB>; Mon, 24 Feb 2003 17:01:01 -0500
Received: from pipgate.pipsworld.sara.nl ([145.100.9.18]:43136 "EHLO
	dinkie.pipsworld.sara.nl") by vger.kernel.org with ESMTP
	id <S267611AbTBXWA7>; Mon, 24 Feb 2003 17:00:59 -0500
Date: Mon, 24 Feb 2003 23:11:11 +0100
From: Remco Post <r.post@sara.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.63 [kernel BUG at drivers/net/tulip/de2104x.c:925!]
Message-Id: <20030224231111.37a560e9.r.post@sara.nl>
In-Reply-To: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reading Oops report from the terminal
kernel BUG at drivers/net/tulip/de2104x.c:925!                                  
Oops: Exception in kernel mode, sig: 4                                          
NIP: C013A454 LR: C013A454 SP: C0277E10 REGS: c0277d60 TRAP: 0700    Not tainted
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11                                 
TASK = c0231530[0] 'swapper' Last syscall: 120                                  
GPR00: C013A454 C0277E10 C0231530 0000002F 00000001 C0277CC8 C0273A00 C02B0000  
GPR08: 00001669 00000000 00000000 C0277D40 4000C088 00000000 00000000 00000000  
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000  
GPR24: 00000000 00000000 00000002 00001032 C03DA000 00009032 FFFFFFCE C03DA1C0  
Call trace: [c013a794]  [c0020710]  [c001b830]  [c0007e80]  [c00061c4]  [c0007b 
Kernel panic: Aiee, killing interrupt handler!                                  
In interrupt handler - not syncing                                              
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
Warning (Oops_read): Code line not seen, dumping what data is available


>>NIP; c013a454 <de_set_media+48/1f0>   <=====

This is on ppc/prep

-- 

Remco
