Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVALPpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVALPpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVALPpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:45:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1774 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261229AbVALPop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:44:45 -0500
Date: Wed, 12 Jan 2005 10:29:07 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, clameter@sgi.com, torvalds@osdl.org,
       ak@muc.de, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
Message-ID: <20050112122907.GB30437@logos.cnet>
References: <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com> <m1652ddljp.fsf@muc.de> <Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com> <41E4BCBE.2010001@yahoo.com.au> <20050112014235.7095dcf4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112014235.7095dcf4.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 01:42:35AM -0800, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > Christoph Lameter wrote:
> >  > Changes from V14->V15 of this patch:
> > 
> >  Hi,
> > 
> >  I wonder what everyone thinks about moving forward with these patches?
> 
> I was waiting for them to settle down before paying more attention.
> 
> My general take is that these patches address a single workload on
> exceedingly rare and expensive machines.  If they adversely affect common
> and cheap machines via code complexity, memory footprint or via runtime
> impact then it would be pretty hard to justify their inclusion.
> 
> Do we have measurements of the negative and/or positive impact on smaller
> machines?

I haven't seen wide performance numbers of this patch yet.

Hint: STP is really easy.
