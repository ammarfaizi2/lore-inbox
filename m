Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTLHUir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTLHUir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:38:47 -0500
Received: from mx1.elte.hu ([157.181.1.137]:16315 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261298AbTLHUiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:38:46 -0500
Date: Mon, 8 Dec 2003 21:38:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zwane Mwaikambo <zwane@zwane.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
In-Reply-To: <3FD3FD52.7020001@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0312082133330.14330@earth>
References: <3FD3FD52.7020001@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Dec 2003, Nick Piggin wrote:

> P.S.
> I have an alternative to Ingo's HT scheduler which basically does the
> same thing. It is showing a 20% elapsed time improvement with a make -j3
> on a 2xP4 Xeon (4 logical CPUs).

if it gets close/equivalent (or better!) performance than the SMT-aware
scheduler i've posted then i'd prefer your patch because yours is
fundamentally simpler. (Btw., there exist a number of similar,
balancing-based HT patches - they are all quite simple.)

	Ingo
