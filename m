Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVLHUle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVLHUle (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVLHUle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:41:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38332 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932328AbVLHUld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:41:33 -0500
Date: Thu, 8 Dec 2005 12:41:28 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Re: pcibus_to_node value when no pxm info is present
 for the pci bus
In-Reply-To: <20051208202138.GD3776@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0512081241180.30546@schroedinger.engr.sgi.com>
References: <20051207223414.GA4493@localhost.localdomain>
 <Pine.LNX.4.62.0512081104280.29958@schroedinger.engr.sgi.com>
 <20051208193439.GB3776@localhost.localdomain> <20051208200440.GB15804@wotan.suse.de>
 <20051208202138.GD3776@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005, Ravikiran G Thirumalai wrote:

> That was my thinking earlier too, but shouldn't we have uniformity in
> behaviour between kmalloc_node and alloc_pages_node wrt nodeid handling?  
> IMHO it would be less confusing that way. alloc_pages_node is not that much 
> of a fastpath routine anyways...

I agree.

