Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbTAVQQB>; Wed, 22 Jan 2003 11:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTAVQQB>; Wed, 22 Jan 2003 11:16:01 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:27330 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262208AbTAVQQA> convert rfc822-to-8bit; Wed, 22 Jan 2003 11:16:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] HT scheduler, sched-2.5.59-D7
Date: Wed, 22 Jan 2003 10:20:56 -0600
User-Agent: KMail/1.4.3
Cc: Erich Focht <efocht@ess.nec.de>, Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
References: <Pine.LNX.4.44.0301202204210.18235-100000@localhost.localdomain> <003301c2c235$2f3123c0$29060e09@andrewhcsltgw8> <35190000.1043252260@titus>
In-Reply-To: <35190000.1043252260@titus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301221020.56503.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 January 2003 10:17, Martin J. Bligh wrote:
> > Michael,  my experience has been that 2.5.59 loaded up the first node
> > before distributing out tasks (at least on kernbench).
>
> Could you throw a printk in map_cpu_to_node and check which cpus come out
> on which nodes?
>
> > I'll try to get some of these tests on x440 asap to compare.
>
> So what are you running on now? the HT stuff?

I am running nothing right now, mainly because I don't have access to that HT 
system anymore. HT-numa may work better than it did with the new load_balance 
idle policy, but I'm not sure it's worth persuing with Ingo's HT patch.  Let 
me know if you think it's worth investigating.

-Andrew Theurer
