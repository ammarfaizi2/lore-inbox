Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVKAN5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVKAN5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVKAN5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:57:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36272 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750789AbVKAN5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:57:15 -0500
Date: Tue, 1 Nov 2005 14:56:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051101135651.GA8502@elte.hu>
References: <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511011014060.14884@skynet>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mel@csn.ul.ie> wrote:

> The set of patches do fix a lot and make a strong start at addressing 
> the fragmentation problem, just not 100% of the way. [...]

do you have an expectation to be able to solve the 'fragmentation 
problem', all the time, in a 100% way, now or in the future?

> So, with this set of patches, how fragmented you get is dependant on 
> the workload and it may still break down and high order allocations 
> will fail. But the current situation is that it will defiantly break 
> down. The fact is that it has been reported that memory hotplug remove 
> works with these patches and doesn't without them. Granted, this is 
> just one feature on a high-end machine, but it is one solid operation 
> we can perform with the patches and cannot without them. [...]

can you always, under any circumstance hot unplug RAM with these patches 
applied? If not, do you have any expectation to reach 100%?

	Ingo
