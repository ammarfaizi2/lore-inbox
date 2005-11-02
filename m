Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbVKBFPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbVKBFPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbVKBFPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:15:12 -0500
Received: from dvhart.com ([64.146.134.43]:31658 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751505AbVKBFPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:15:10 -0500
Date: Tue, 01 Nov 2005 21:14:51 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Joel Schopp <jschopp@austin.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <231260000.1130908490@[10.10.2.4]>
In-Reply-To: <43684A16.70401@yahoo.com.au>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com> <43681100.1000603@yahoo.com.au> <214340000.1130895665@[10.10.2.4]> <43681E89.8070905@yahoo.com.au> <216280000.1130898244@[10.10.2.4]> <43682940.3020200@yahoo.com.au> <217570000.1130906356@[10.10.2.4]> <43684A16.70401@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's not just about memory hotplug. There are, as we have discussed
>> already, many usage for physically contiguous (and virtually contiguous)
>> memory segments. Focusing purely on any one of them will not solve the
>> issue at hand ...
> 
> True, but we don't seem to have huge problems with other things. The
> main ones that have come up on lkml are e1000 which is getting fixed,
> and maybe XFS which I think there are also moves to improve.

It should be fairly easy to trawl through the list of all allocations 
and pull out all the higher order ones from the whole source tree. I
suspect there's a lot ... maybe I'll play with it later on.

M.

