Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbTLHQCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265438AbTLHQCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:02:12 -0500
Received: from dp.samba.org ([66.70.73.150]:44450 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265476AbTLHQB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:01:58 -0500
Date: Tue, 9 Dec 2003 02:59:04 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zwane Mwaikambo <zwane@zwane.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
Message-ID: <20031208155904.GF19412@krispykreme>
References: <3FD3FD52.7020001@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD3FD52.7020001@cyberone.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I'm not aware of any reason why the kernel should not become generally
> SMT aware. It is sufficiently different to SMP that it is worth
> specialising it, although I am only aware of P4 and POWER5 implementations.

I agree, SMT is likely to become more popular in the coming years.

> I have an alternative to Ingo's HT scheduler which basically does
> the same thing. It is showing a 20% elapsed time improvement with a
> make -j3 on a 2xP4 Xeon (4 logical CPUs).
> 
> Before Ingo's is merged, I would like to discuss the pros and cons of
> both approaches with those interested. If Ingo's is accepted I should
> still be able to port my other SMP/NUMA improvements on top of it.

Sounds good, have you got anything to test? I can throw it on a POWER5.

Anton
