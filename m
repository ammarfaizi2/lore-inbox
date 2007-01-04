Return-Path: <linux-kernel-owner+w=401wt.eu-S1030233AbXADVQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbXADVQR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbXADVQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:16:17 -0500
Received: from verein.lst.de ([213.95.11.210]:59315 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030233AbXADVQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:16:16 -0500
Date: Thu, 4 Jan 2007 22:15:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, apw@shadowen.org, hch@lst.de,
       manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
Subject: Re: [PATCH] slab: cache alloc cleanups
Message-ID: <20070104211543.GA21917@lst.de>
References: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.001 () BAYES_44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 03:47:06PM +0200, Pekka J Enberg wrote:
> [Andrew, I have been unable to find a NUMA-capable tester for this patch, 
>  so can we please put this in to -mm for some exposure?]
> 
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch cleans up __cache_alloc and __cache_alloc_node functions.  We no
> longer need to do NUMA_BUILD tricks and the UMA allocation path is much
> simpler. Note: we now do alternate_node_alloc() for kmem_cache_alloc_node as
> well.

Seems to work nicely on my 2node cell blade. 

