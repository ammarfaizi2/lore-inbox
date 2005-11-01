Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVKAPZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVKAPZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVKAPZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:25:48 -0500
Received: from dvhart.com ([64.146.134.43]:46761 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750872AbVKAPZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:25:47 -0500
Date: Tue, 01 Nov 2005 07:25:44 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Mel Gorman <mel@csn.ul.ie>
Cc: Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <45430000.1130858744@[10.10.2.4]>
In-Reply-To: <4366C559.5090504@yahoo.com.au>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really don't think we *want* to say we support higher order allocations
> absolutely robustly, nor do we want people using them if possible. Because
> we don't. Even with your patches.
> 
> Ingo also brought up this point at Ottawa.

Some of the driver issues can be fixed by scatter-gather DMA *if* the 
h/w supports it. But what exactly do you propose to do about kernel
stacks, etc? By the time you've fixed all the individual usages of it,
frankly, it would be easier to provide a generic mechanism to fix the 
problem ...
 
M.
