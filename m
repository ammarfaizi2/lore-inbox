Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUL2RxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUL2RxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 12:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbUL2RxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 12:53:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61369 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261380AbUL2RxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 12:53:01 -0500
Date: Wed, 29 Dec 2004 23:22:58 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reimplementation of linux dynamic percpu memory allocator
Message-ID: <20041229175258.GC2075@impedimenta.in.ibm.com>
References: <41C35DD6.1050804@colorfullife.com> <20041220182057.GA16859@in.ibm.com> <41C718C7.1020908@colorfullife.com> <20041220192558.GA17194@in.ibm.com> <41D2DC68.5080805@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D2DC68.5080805@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 05:33:44PM +0100, Manfred Spraul wrote:
> Ravikiran G Thirumalai wrote:
> 
> >On Mon, Dec 20, 2004 at 07:24:07PM +0100, Manfred Spraul wrote:
> > 
> >
> >>No, not fast path. But it can happen a few thousand times. The slab 
> >>implementation failed due to heavy internal fragmentation. If your code 
> >>runs fine with a few thousand users, then there shouldn't be a problem.
> >>   
> >>
> >
> > 
> >
> Could you ask Badari Pulavarty (pbadari@us.ibm.com)?
> He noticed the fragmentation problem with the original 
> kmem_cache_alloc_node implementation. Perhaps he could just run your 
> version with his test setup:

Yes I will.  Thanks for the pointer.


Thanks,
Kiran
