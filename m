Return-Path: <linux-kernel-owner+w=401wt.eu-S965071AbXADSlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbXADSlu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbXADSlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:41:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41754 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965071AbXADSls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:41:48 -0500
Date: Thu, 4 Jan 2007 10:41:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, Pekka J Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix BUG_ON(!PageSlab) from fallback_alloc
In-Reply-To: <Pine.LNX.4.64.0701041741490.16466@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0701041041110.21800@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0701041741490.16466@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Hugh Dickins wrote:

> Fixes a CONFIG_NUMA regression introduced in 2.6.20-rc1.  Or you may
> feel it's cleaner for cache_grow to skip its kmem_freepages when objp
> is input: patch below is slightly simpler, but I've no strong feeling.

Acked-by: Christoph Lameter <clameter@sgi.com>
