Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTLJWG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 17:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTLJWG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 17:06:28 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:53406 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S264254AbTLJWG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 17:06:26 -0500
Date: Wed, 10 Dec 2003 23:05:25 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031210220525.GA28912@k3.hellgate.ch>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031210215235.GC11193@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210215235.GC11193@dualathlon.random>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003 22:52:35 +0100, Andrea Arcangeli wrote:
> On Mon, Dec 08, 2003 at 12:48:17PM -0800, William Lee Irwin III wrote:
> > qsbench I'd pretty much ignore except as a control case, since there's
> > nothing to do with a single process but let it thrash.
> 
> this is not the point. If a single process like qsbench trashes twice as
> fast in 2.4, it means 2.6 has some great problem in the core vm, the
> whole point of swap is to trash but to give the task more physical
> virtual memory. I doubt you can solve it with anything returned by
> si_swapinfo.

Uhm.. guys? I forgot to mention that earlier: qsbench as I used it was not
about one single process. There were four worker processes (-p 4), and my
load control stuff did make it run faster, so the point is moot.

Also, the 2.6 core VM doesn't seem all that bad since it was introduced in
2.5.27 but most of the problems I measured were introduced after 2.5.40.
Check out the graph I posted.

Thank you, we now return to our regularly scheduled programming.

Roger
