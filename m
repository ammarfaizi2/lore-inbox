Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbTATTuF>; Mon, 20 Jan 2003 14:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbTATTtP>; Mon, 20 Jan 2003 14:49:15 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:23707 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266936AbTATTsJ> convert rfc822-to-8bit;
	Mon, 20 Jan 2003 14:48:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] sched-2.5.59-A2
Date: Mon, 20 Jan 2003 13:52:55 -0600
User-Agent: KMail/1.4.3
Cc: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>
References: <Pine.LNX.4.44.0301201817220.12564-100000@localhost.localdomain> <200301201313.39621.habanero@us.ibm.com> <262510000.1043091224@flay>
In-Reply-To: <262510000.1043091224@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301201352.55534.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I have included a very rough patch to do ht-numa topology.  I requires to
> > manually define CONFIG_NUMA and CONFIG_NUMA_SCHED.  It also uses
> > num_cpunodes instead of numnodes and defines MAX_NUM_NODES to 8 if
> > CONFIG_NUMA is defined.
>
> Whilst it's fine for benchmarking, I think this kind of overlap is a
> very bad idea long-term - the confusion introduced is just asking for
> trouble. And think what's going to happen when you mix HT and NUMA.
> If we're going to use this for HT, it needs abstracting out.

I have no issues with using HT specific bits instead of NUMA.  Design wise it 
would be nice if it could all be happy together, but if not, then so be it.  

-Andrew Theurer
