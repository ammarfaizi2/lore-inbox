Return-Path: <linux-kernel-owner+w=401wt.eu-S1422678AbXAETGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422678AbXAETGV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbXAETGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:06:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42836 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422678AbXAETGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:06:20 -0500
Date: Fri, 5 Jan 2007 11:05:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, apw@shadowen.org, hch@lst.de,
       manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
Subject: Re: [PATCH] slab: cache alloc cleanups
In-Reply-To: <Pine.LNX.4.64.0701051345040.20220@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0701051104520.28080@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0701051345040.20220@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Pekka J Enberg wrote:

> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> Clean up __cache_alloc and __cache_alloc_node functions a bit.  We no 
> longer need to do NUMA_BUILD tricks and the UMA allocation path is much
> simpler. No functional changes in this patch.

Looks good.

