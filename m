Return-Path: <linux-kernel-owner+w=401wt.eu-S1754853AbXABO34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbXABO34 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 09:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754851AbXABO3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 09:29:55 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3524 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbXABO3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 09:29:55 -0500
Message-ID: <459A6C59.5090007@shadowen.org>
Date: Tue, 02 Jan 2007 14:29:45 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.helsinki.fi>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@lst.de,
       manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
Subject: Re: [PATCH] slab: cache alloc cleanups
References: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> [Andrew, I have been unable to find a NUMA-capable tester for this patch, 
>  so can we please put this in to -mm for some exposure?]
> 
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch cleans up __cache_alloc and __cache_alloc_node functions.  We no
> longer need to do NUMA_BUILD tricks and the UMA allocation path is much
> simpler. Note: we now do alternate_node_alloc() for kmem_cache_alloc_node as
> well.

I'll push this through our tests here if that helps.  I need to rerun
the -rc2-mm1 tests by the looks of it ... looks like the test lab had
some time off over Christmas.

-apw
