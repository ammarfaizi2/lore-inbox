Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVJQQKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVJQQKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbVJQQKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:10:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:33422 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751420AbVJQQKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:10:09 -0400
Subject: Re: [Patch 2/3] Export get_one_pte_map.
From: Dave Hansen <haveblue@us.ibm.com>
To: Robin Holt <holt@sgi.com>
Cc: Greg KH <greg@kroah.com>, Hugh Dickins <hugh@veritas.com>,
       ia64 list <linux-ia64@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org, jgarzik@pobox.com,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Carsten Otte <cotte@de.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
In-Reply-To: <20051017155605.GB2564@lnx-holt.americas.sgi.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com>
	 <20051014192225.GD14418@lnx-holt.americas.sgi.com>
	 <20051014213038.GA7450@kroah.com>
	 <20051017113131.GA30898@lnx-holt.americas.sgi.com>
	 <1129549312.32658.32.camel@localhost>
	 <20051017114730.GC30898@lnx-holt.americas.sgi.com>
	 <Pine.LNX.4.61.0510171331090.2993@goblin.wat.veritas.com>
	 <20051017151430.GA2564@lnx-holt.americas.sgi.com>
	 <20051017152034.GA32286@kroah.com>
	 <20051017155605.GB2564@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 18:09:39 +0200
Message-Id: <1129565379.9839.42.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 10:56 -0500, Robin Holt wrote:
> On Mon, Oct 17, 2005 at 08:20:34AM -0700, Greg KH wrote:
> > > Would it be reasonable to ask that the current patch be included and
> > > then I work up another patch which introduces a ->nopfn type change
> > > for the -mm tree?
> > 
> > The stuff in -mm is what is going to be in .15, so you have to work off
> > of that patchset if you wish to have something for .15.
> 
> Is everything in the mm/ directory from the -mm tree going into .15 or
> is there a planned subset?  What should I develop against to help ensure
> I match up with the community?

I'd just work on top of the entire -mm tree for now.  Or, check out the
patch-series file and the broken-out/ directory in the tree's directory
on kernel.org.  You can apply only the patches that are in the mm
section (it's commented), they're just about first after the -git trees.

-- Dave

