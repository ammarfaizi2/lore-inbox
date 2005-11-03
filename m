Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVKCPge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVKCPge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVKCPge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:36:34 -0500
Received: from dvhart.com ([64.146.134.43]:55469 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030342AbVKCPgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:36:33 -0500
Date: Thu, 03 Nov 2005 07:36:34 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <306020000.1131032193@[10.10.2.4]>
In-Reply-To: <4369824E.2020407@yahoo.com.au>
References: <4366C559.5090504@yahoo.com.au>	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>	 <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu>	 <1130856555.14475.77.camel@localhost> <20051101150142.GA10636@elte.hu>	 <1130858580.14475.98.camel@localhost> <20051102084946.GA3930@elte.hu>	 <436880B8.1050207@yahoo.com.au> <1130923969.15627.11.camel@localhost> <43688B74.20002@yahoo.com.au> <255360000.1130943722@[10.10.2.4]> <4369824E.2020407@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can we quit coming up with specialist hacks for hotplug, and try to solve
>> the generic problem please? hotplug is NOT the only issue here. Fragmentation
>> in general is.
>> 
> 
> Not really it isn't. There have been a few cases (e1000 being the main
> one, and is fixed upstream) where fragmentation in general is a problem.
> But mostly it is not.

Sigh. OK, tell me how you're going to fix kernel stacks > 4K please. And 
devices that don't support scatter-gather DMA.
 
M.

