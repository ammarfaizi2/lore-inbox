Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVKDRt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVKDRt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVKDRt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:49:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750773AbVKDRt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:49:57 -0500
Date: Fri, 4 Nov 2005 09:49:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Nelson <andy@thermo.lanl.gov>
cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <20051104170359.80947184684@thermo.lanl.gov>
Message-ID: <Pine.LNX.4.64.0511040943130.27921@g5.osdl.org>
References: <20051104170359.80947184684@thermo.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Nov 2005, Andy Nelson wrote:
> 
> Ok. In other posts you have skeptically accepted Power as a
> `modern' architecture.

Yes, sceptically.

I'd really like to hear what your numbers are on a modern x86. Any x86-64 
is interesting, and I can't imagine that with a LANL address you can't 
find any.

I do believe that Power is within one order of magnitude of a modern x86 
when it comes to TLB fill performance. That's much better than many 
others, but whether "almost as good" is within the error range, or whether 
it's "only five times worse", I don't know.

The thing is, there's a reason x86 machines kick ass. They are cheap, and 
they really _do_ outperform pretty much everything else out there.

Power 5 has a wonderful memory architecture, and those L3 caches kick ass. 
They probably don't help you as much as they help databases, though, and 
it's entirely possible that a small cheap Opteron with its integrated 
memory controller will outperform them on your load if you really don't 
have a lot of locality.

			Linus
