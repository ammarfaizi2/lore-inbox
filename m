Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269870AbUICWPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269870AbUICWPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269875AbUICWPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:15:39 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:50344 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269870AbUICWOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:14:41 -0400
Subject: Re: [Fwd: Re: SMP Panic caused by [PATCH] sched: consolidate sched
	domains]
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, wli@holomorphy.com,
       jbarnes@engr.sgi.com, colpatch@us.ibm.com, nickpiggin@yahoo.com.au,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040903145925.1e7aedd3.akpm@osdl.org>
References: <1094246465.1712.12.camel@mulgrave> 
	<20040903145925.1e7aedd3.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 03 Sep 2004 18:13:56 -0400
Message-Id: <1094249638.1712.19.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 17:59, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > Could we get this in please?  The current screw up in the scheduling
> > domain patch means that any architecture that actually hotplugs CPUs
> > will crash in find_busiest_group() ... and I notice this has just bitten
> > the z Series people...
> 
> Have we yet seen anything which looks like a completed and tested patch?

The attached was what I've tested on parisc.  It looks complete to me;
what's wrong with it?

James


