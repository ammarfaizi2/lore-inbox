Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWDKX3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWDKX3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 19:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWDKX3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 19:29:47 -0400
Received: from mailhub.hp.com ([192.151.27.10]:42640 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1751355AbWDKX3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 19:29:46 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Tue, 11 Apr 2006 19:29:44 -0400
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
       davej@codemonkey.org.uk, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture independent manner
Message-ID: <20060411232944.GE23742@localhost>
References: <20060411103946.18153.83059.sendpatchset@skynet> <20060411222029.GA7743@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411222029.GA7743@agluck-lia64.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

luck wrote:	[Tue Apr 11 2006, 06:20:29PM EDT]
> On Tue, Apr 11, 2006 at 11:39:46AM +0100, Mel Gorman wrote:
> 
> > The patches have only been *compile tested* for ia64 with a flatmem
> > configuration. At attempt was made to boot test on an ancient RS/6000
> > but the vanilla kernel does not boot so I have to investigate there.
> 
> The good news: Compilation is clean on the ia64 config variants that
> I usually build (all 10 of them).
> 
> The bad (or at least consistent) news: It doesn't boot on an Intel
> Tiger either (oops at kmem_cache_alloc+0x41).
> 
> -Tony
I had a reply queued to report the same failure with
DISCONTIG+NUMA+VIRTUAL_MEM_MAP.  This was 2 CPU HP rx2600. I'll take a closer 
look at the code tomorrow. 

bob
