Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbTATQpI>; Mon, 20 Jan 2003 11:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266259AbTATQpI>; Mon, 20 Jan 2003 11:45:08 -0500
Received: from mx1.elte.hu ([157.181.1.137]:3971 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266257AbTATQpF>;
	Mon, 20 Jan 2003 11:45:05 -0500
Date: Mon, 20 Jan 2003 17:59:39 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
In-Reply-To: <1372810000.1043079799@titus>
Message-ID: <Pine.LNX.4.44.0301201758120.11746-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Jan 2003, Martin J. Bligh wrote:

> I think we definitely need to tune this on a per-arch basis. There's no
> way that one-size-fits-all is going to fit a situation as complex as
> this (though we can definitely learn from each other's analysis).

agreed - although the tunable should be constant (if possible, or
boot-established but not /proc exported), and there should be as few
tunables as possible. We already tune some of our scheduler behavior to
the SMP cachesize. (the cache_decay_ticks SMP logic.)

	Ingo

