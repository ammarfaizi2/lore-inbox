Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVHCO4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVHCO4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVHCO4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:56:04 -0400
Received: from galileo.bork.org ([134.117.69.57]:57280 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S262265AbVHCO4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:56:02 -0400
Date: Wed, 3 Aug 2005 10:56:00 -0400
From: Martin Hicks <mort@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linux MM <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: add vm.free_node_memory sysctl
Message-ID: <20050803145600.GS26803@localhost>
References: <20050801113913.GA7000@elte.hu> <20050801102903.378da54f.akpm@osdl.org> <20050801195426.GA17548@elte.hu> <20050802171050.GG26803@localhost> <20050802210746.GA26494@elte.hu> <20050803135646.GO26803@localhost> <20050803141529.GX10895@wotan.suse.de> <20050803142440.GQ26803@localhost> <20050803143855.GA10895@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803143855.GA10895@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Aug 03, 2005 at 04:38:55PM +0200, Andi Kleen wrote:
> On Wed, Aug 03, 2005 at 10:24:40AM -0400, Martin Hicks wrote:
> 
> > zone_reclaim() path doesn't let the memory reclaim code swap.
> 
> reclaim with bound policy should only swap on the bound nodemask
> (or at least it did when I originally implemented NUMA policy) 

Yes, it still looks like it only swaps on the bound nodemask.

mh

-- 
Martin Hicks   ||   Silicon Graphics Inc.   ||   mort@sgi.com
