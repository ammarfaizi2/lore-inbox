Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUFDSLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUFDSLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUFDSLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:11:04 -0400
Received: from [65.39.167.249] ([65.39.167.249]:45960 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S265805AbUFDSLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:11:01 -0400
Date: Fri, 4 Jun 2004 14:11:00 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
In-Reply-To: <20040604155138.GG16897@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0406041408220.31276@innerfire.net>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de>
 <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com>
 <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
 <20040604154142.GF16897@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org>
 <20040604155138.GG16897@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004, Arjan van de Ven wrote:

> I know that in a FC1 full install there are less than 5 binaries that don't
> run with NX. (one uses nested functions in C and passes function pointers to
> the inner function around which causes gcc to emit a stack trampoline, and
> gcc then marks the binary as non-NX, the others have asm in them that we
> didn't fix in time to be properly marked).

Can you tell if GCC uses trampolines for all use of function pointers or
just ones that use nested functions ?

Also, what is the fastest way to check if GCC is marking non-NX?

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
