Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbVKHTKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbVKHTKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVKHTKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:10:30 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:45759 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030334AbVKHTK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:10:29 -0500
Date: Tue, 8 Nov 2005 11:09:31 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Roland Dreier <rolandd@cisco.com>, kernel-janitors@lists.osdl.org,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Cleanup kmem_cache_create()
In-Reply-To: <4370F6BB.1070409@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0511081108340.31060@schroedinger.engr.sgi.com>
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com>
 <52mzkfrily.fsf@cisco.com> <Pine.LNX.4.62.0511081049520.30907@schroedinger.engr.sgi.com>
 <4370F6BB.1070409@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Matthew Dobson wrote:

> > A large object in terms of this patch is a object greater than 4096 bytes 
> > not an object greater than PAGE_SIZE. I think the absolute size is 
> > desired.
> Would you be OK with at least NAMING the constant?  I won't name it
> PAGE_SIZE (of course), but LARGE_OBJECT_SIZE or something?

Ask Manfred about this. I think he coded it that way and he usually has 
good reasons for it.

Thanks for the cleanup work!

