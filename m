Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbTLRXjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbTLRXjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:39:46 -0500
Received: from holomorphy.com ([199.26.172.102]:35221 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265401AbTLRXjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:39:44 -0500
Date: Thu, 18 Dec 2003 15:38:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: rl@hellgate.ch, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       kernel@kolivas.org, chris@cvine.freeserve.co.uk,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031218233833.GE22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rl@hellgate.ch, Rik van Riel <riel@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	kernel@kolivas.org, chris@cvine.freeserve.co.uk,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com
References: <20031217214107.GA3650@k3.hellgate.ch> <Pine.LNX.4.44.0312171921180.12531-100000@chimarrao.boston.redhat.com> <20031218225324.GA24850@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218225324.GA24850@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 11:53:25PM +0100, Roger Luethi wrote:
> Depends on the axis in your graph. The benchmarks I am using are not
> balancing on the verge of going bad, if that's what you mean. They
> cut deep (30 to 100 MB) into swap through most of their run time,
> and there's quite a bit of swap turnover with compiling stuff.
> I also completed a best effort attempt at determining the impact of
> any differences between mem= and actual RAM removal. I had to adapt
> the kbuild benchmark somewhat to the available hardware. I benchmarked
> with 48 MB RAM at mem=16M and again after removing 32MB of RAM. If there
> was a difference in performance, it was very small for both 2.4.23 and
> 2.6.0-test11, with the latter taking over 2.5 times as long to complete
> the benchmark.

A bogon was recently fixed in 2.6 that caused the results to differ.
They should not differ.


-- wli
