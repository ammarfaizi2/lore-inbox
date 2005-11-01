Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVKAPYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVKAPYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVKAPYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:24:10 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:59334 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750879AbVKAPYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:24:07 -0500
Date: Tue, 1 Nov 2005 15:24:03 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <1130856658.14475.79.camel@localhost>
Message-ID: <Pine.LNX.4.58.0511011523130.14884@skynet>
References: <20051030235440.6938a0e9.akpm@osdl.org>  <27700000.1130769270@[10.10.2.4]>
 <4366A8D1.7020507@yahoo.com.au>  <Pine.LNX.4.58.0510312333240.29390@skynet>
 <4366C559.5090504@yahoo.com.au>  <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au>  <Pine.LNX.4.58.0511011014060.14884@skynet>
 <20051101135651.GA8502@elte.hu>  <Pine.LNX.4.58.0511011358520.14884@skynet>
 <1130856658.14475.79.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Dave Hansen wrote:

> On Tue, 2005-11-01 at 14:41 +0000, Mel Gorman wrote:
> > o Mechanism for taking regions of memory offline. Again, I think the
> >   memory hotplug crowd have something for this. If they don't, one of them
> >   will chime in.
>
> I'm not sure what you're asking for here.
>
> Right now, you can offline based on NUMA node, or physical address.
> It's all revealed in sysfs.  Sounds like "regions" to me. :)
>

Ah yes, that would do the job all right.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
