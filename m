Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWDKWUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWDKWUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWDKWUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:20:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:63531 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751159AbWDKWUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:20:31 -0400
X-IronPort-AV: i="4.04,113,1144047600"; 
   d="scan'208"; a="22100064:sNHT63165725"
Date: Tue, 11 Apr 2006 15:20:29 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture independent manner
Message-ID: <20060411222029.GA7743@agluck-lia64.sc.intel.com>
References: <20060411103946.18153.83059.sendpatchset@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411103946.18153.83059.sendpatchset@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 11:39:46AM +0100, Mel Gorman wrote:

> The patches have only been *compile tested* for ia64 with a flatmem
> configuration. At attempt was made to boot test on an ancient RS/6000
> but the vanilla kernel does not boot so I have to investigate there.

The good news: Compilation is clean on the ia64 config variants that
I usually build (all 10 of them).

The bad (or at least consistent) news: It doesn't boot on an Intel
Tiger either (oops at kmem_cache_alloc+0x41).

-Tony
