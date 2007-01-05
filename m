Return-Path: <linux-kernel-owner+w=401wt.eu-S1161154AbXAERrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbXAERrM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbXAERrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:47:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36763 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161154AbXAERrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:47:11 -0500
Date: Fri, 5 Jan 2007 09:47:03 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: fix double-free in fallback_alloc
In-Reply-To: <Pine.LNX.4.64.0701051127180.17184@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0701050946360.28080@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0701051127180.17184@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Pekka J Enberg wrote:

> Here's an alternative fix for the double-free bug you hit. I have only 
> compile-tested this on NUMA so can you please confirm it fixes the problem 
> for you? Thanks.

Looks good to me.
