Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVJQQAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVJQQAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVJQQAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:00:15 -0400
Received: from gold.veritas.com ([143.127.12.110]:50274 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751414AbVJQQAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:00:12 -0400
Date: Mon, 17 Oct 2005 16:59:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Robin Holt <holt@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Greg KH <greg@kroah.com>, ia64 list <linux-ia64@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org, jgarzik@pobox.com,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Carsten Otte <cotte@de.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: Re: [Patch 2/3] Export get_one_pte_map.
In-Reply-To: <20051017151430.GA2564@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.61.0510171644220.4773@goblin.wat.veritas.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com>
 <20051014192225.GD14418@lnx-holt.americas.sgi.com> <20051014213038.GA7450@kroah.com>
 <20051017113131.GA30898@lnx-holt.americas.sgi.com> <1129549312.32658.32.camel@localhost>
 <20051017114730.GC30898@lnx-holt.americas.sgi.com>
 <Pine.LNX.4.61.0510171331090.2993@goblin.wat.veritas.com>
 <20051017151430.GA2564@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Oct 2005 16:00:12.0334 (UTC) FILETIME=[DB24C4E0:01C5D333]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005, Robin Holt wrote:
> 
> I am currently getting pressure from my management to get something
> checked into the tree for 2.6.15.

I'm sorry to hear that, but it's not a kernel development priority.

And since I'm nearing completion of a task which we expect to satisfy
what SGI's been asking for almost a year, which I had been obstructing,
I'm disinclined to drop it now in order to help meet their latest fancy.

> Would it be reasonable to ask
> that the current patch be included and then I work up another patch
> which introduces a ->nopfn type change for the -mm tree?

I'm definitely not in charge here, and cannot answer that.  But I
think it's unlikely, unless Linus and Andrew are pretty sure that
what you have now is really the way they want to go in the long term.

You will, as ever, be entitled to apply your patch on top of 2.6.15
(but it may not apply without some changes).

Repeating a technical question (sorry, that now seems off-topic!):
what do you expect to happen with PROT_WRITE, MAP_PRIVATE?

Hugh
