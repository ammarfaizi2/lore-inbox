Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWCUQdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWCUQdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWCUQdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:33:43 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11392 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030361AbWCUQaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:30:21 -0500
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060321032521.03a8d6de.akpm@osdl.org>
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
	 <20060321032521.03a8d6de.akpm@osdl.org>
Date: Tue, 21 Mar 2006 18:30:16 +0200
Message-Id: <1142958616.21308.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> >
> > This patch introduces a memory-zeroing variant of kmem_cache_alloc.
> >

On Tue, 2006-03-21 at 03:25 -0800, Andrew Morton wrote:
> Problem is, after I've weathered 10000000000 convert-to-kmem_cache_zalloc
> patches, those pestiferous NUMA people are going to come along wanting
> kmem_cache_kzalloc_node().
> 
> Probably this should be designed for up-front?

Actually, we don't even have kzalloc_node, so I'd say we're better of
waiting for the NUMA folk to ask for them. Hum?

				Pekka

