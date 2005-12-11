Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVLKSOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVLKSOO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVLKSOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:14:14 -0500
Received: from waste.org ([64.81.244.121]:25234 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750767AbVLKSON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:14:13 -0500
Date: Sun, 11 Dec 2005 10:08:20 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: SLOB wishlist
Message-ID: <20051211180820.GX8637@waste.org>
References: <20051211141716.GA8500@elte.hu> <20051211142353.GA10131@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211142353.GA10131@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 03:23:53PM +0100, Ingo Molnar wrote:
> 
> btw., here's my SLOB wishlist:
> 
>  - would be nice to have DEBUG_SLOB - people want to debug their memory 
>    allocations, no matter which allocator they use.

I have a patch somewhere for that.

>  - would be nice to have CONFIG_SLOB_INFO, to have /proc/slabinfo for 
>    those who are ready to pay the .text price for it - this is nice for 
>    memory leak debugging, etc. [should be /proc/slabinfo, not 
>    /proc/slobinfo - to stay compatible with things like slabtop]

Might make more sense to use my /proc/kmalloc patch for this.

-- 
Mathematics is the supreme nostalgia of our time.
