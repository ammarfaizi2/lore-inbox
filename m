Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbTLIQF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266051AbTLIQF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:05:29 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:2239 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S266049AbTLIQFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:05:24 -0500
Date: Tue, 9 Dec 2003 11:04:49 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Roger Luethi <rl@hellgate.ch>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       <linux-kernel@vger.kernel.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
In-Reply-To: <20031209151103.GA4837@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.44.0312091103100.8917-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Roger Luethi wrote:

> The classic strategies based on these criteria work for transaction and
> batch systems. They are all but useless, though, for a workstation and
> even most modern servers, due to assumptions that are incorrect today
> (remember all the degrees of freedom a scheduler had 30 years ago)
> and additional factors that only became crucial in the past few decades
> (latency again).

Don't forget that computers have gotten a lot slower
over the years ;)

Swapping out a 64kB process to a disk that does 180kB/s
is a lot faster than swapping out a 100MB process to a
disk that does 50MB/s ...

Once you figure in seek times, the picture looks even
worse.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

