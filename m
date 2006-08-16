Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWHPImx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWHPImx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWHPImx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:42:53 -0400
Received: from waste.org ([66.93.16.53]:5788 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751009AbWHPImw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:42:52 -0400
Date: Wed, 16 Aug 2006 03:41:19 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Lameter <clameter@sgi.com>, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
Message-ID: <20060816084119.GW6908@waste.org>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com> <20060816095254.14ac872c.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816095254.14ac872c.ak@muc.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 09:52:54AM +0200, Andi Kleen wrote:
> > 1. shrink_slab takes a function to move object. Using that
> >    function slabs can be defragmented to ease slab reclaim.
> 
> Does that help with the inefficient dcache/icache pruning? 

There was a fair amount of debate on this at the VM summit.

The approach we thought was most promising started with splitting the
dcache into directory and leaf entries.

-- 
Mathematics is the supreme nostalgia of our time.
