Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbVJQPPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbVJQPPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVJQPPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:15:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43956 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751394AbVJQPPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:15:15 -0400
Date: Mon, 17 Oct 2005 10:14:30 -0500
From: Robin Holt <holt@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Robin Holt <holt@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       Greg KH <greg@kroah.com>, ia64 list <linux-ia64@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org, jgarzik@pobox.com,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Carsten Otte <cotte@de.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: Re: [Patch 2/3] Export get_one_pte_map.
Message-ID: <20051017151430.GA2564@lnx-holt.americas.sgi.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com> <20051014192225.GD14418@lnx-holt.americas.sgi.com> <20051014213038.GA7450@kroah.com> <20051017113131.GA30898@lnx-holt.americas.sgi.com> <1129549312.32658.32.camel@localhost> <20051017114730.GC30898@lnx-holt.americas.sgi.com> <Pine.LNX.4.61.0510171331090.2993@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510171331090.2993@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 01:33:53PM +0100, Hugh Dickins wrote:
> On Mon, 17 Oct 2005, Robin Holt wrote:
> > On Mon, Oct 17, 2005 at 01:41:52PM +0200, Dave Hansen wrote:
> > > On Mon, 2005-10-17 at 06:31 -0500, Robin Holt wrote:
> > > > On Fri, Oct 14, 2005 at 02:30:38PM -0700, Greg KH wrote:
> > > > > On Fri, Oct 14, 2005 at 02:22:25PM -0500, Robin Holt wrote:
> > > > > > +EXPORT_SYMBOL(get_one_pte_map);
> > 
> > I got a little push from our internal incident tracking system for
> > this being a module.  _GPL it will be.
> 
> Sorry, Robin, I've not been following your patches.  But if you look
> at 2.6.14-rc4-mm1, you'll find that there isn't even a get_one_pte_map
> there.  Though there's no certainty yet that my pt locking changes, or
> Nick's PageReserved changes, will actually go forward, there's a lot of
> work queued up in -mm that is likely to affect your code.  And I don't
> think exporting internal functions from mremap.c, _GPL or otherwise,
> is the way to go.

I am currently getting pressure from my management to get something
checked into the tree for 2.6.15.  Would it be reasonable to ask
that the current patch be included and then I work up another patch
which introduces a ->nopfn type change for the -mm tree?

Thanks,
Robin

