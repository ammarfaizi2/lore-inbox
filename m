Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTJ0UxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTJ0UxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:53:02 -0500
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:35456
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263580AbTJ0Uw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:52:59 -0500
Date: Mon, 27 Oct 2003 15:52:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Ingo Oeser <ioe-lkml@rameria.de>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86
 Architecture
In-Reply-To: <20031027152001.GC27333@werewolf.able.es>
Message-ID: <Pine.LNX.4.53.0310271549240.21953@montezuma.fsmlabs.com>
References: <200310221855.15925.theman@josephdwagner.info>
 <20031023230542.GC2084@werewolf.able.es> <200310241301.41230.ioe-lkml@rameria.de>
 <20031027152001.GC27333@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, J.A. Magallon wrote:

> Patch inlined. Credits should go to Zwane Mwaikambo <zwane@linux.realnet.co.sz>.
> It adds the corresponding flags for PII) and P4, and in case thei are defined,
> the *fence insn are used.

Andi Kleen did something nice which automagically replaces barrier 
instructions in 2.6 w/ his 'alternative' code ("include/asm-i386/system.h" 
479L)

> Included is also one other patch by Zwane, which states that smp_call_function
> needs mb() instead of wmb().

Hasn't this made it into 2.4 yet? It should at least be in -ac(-pac?) i'll 
try and send it off to Marcelo again.

Thanks,
	Zwane

