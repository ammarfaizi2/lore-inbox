Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVICBkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVICBkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 21:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVICBkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 21:40:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27825 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750996AbVICBkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 21:40:07 -0400
Date: Fri, 2 Sep 2005 18:33:52 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
In-Reply-To: <4318C395.1080203@yahoo.com.au>
Message-ID: <Pine.LNX.4.62.0509021832080.18691@schroedinger.engr.sgi.com>
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>
 <4317F136.4040601@yahoo.com.au> <Pine.LNX.4.62.0509021123290.15836@schroedinger.engr.sgi.com>
 <4318C395.1080203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Sep 2005, Nick Piggin wrote:

> Thanks Christoph, I think this will be required to support 386.
> In the worst case, we could provide a fallback path and take
> ->tree_lock in pagecache lookups if there is no atomic_cmpxchg,
> however I would much prefer all architectures get an atomic_cmpxchg,
> and I think it should turn out to be a generally useful primitive.
> 
> I may trim this down to only provide what is needed for atomic_cmpxchg
> if that is OK?

Do not hesitate to do whatever you need to the patch. I took what I 
needed from you for this patch last year too.

