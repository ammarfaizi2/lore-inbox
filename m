Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269360AbUHZSy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269360AbUHZSy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUHZSuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:50:00 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43743 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269360AbUHZSlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:41:36 -0400
Date: Thu, 26 Aug 2004 13:38:34 -0500
From: John Hesterberg <jh@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jay Lan <jlan@engr.sgi.com>, linux-kernel@vger.kernel.org,
       erikj@dbear.engr.sgi.com, limin@engr.sgi.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
Message-ID: <20040826183834.GA11393@sgi.com>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825221842.72dd83a4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 10:18:42PM -0700, Andrew Morton wrote:
> Jay Lan <jlan@engr.sgi.com> wrote:
> >
> > I have broken up one big CSA kernel patch into four smaller ones
> >  as attached:
> > 
> >       csa_io     - collects io accounting data
> >       csa_mm     - collects mm accounting data
> >       csa_eop    - provides a hook to perform end-of-process accounting
> >       csa_module - builds csa loadable module
> 
> More broadly: Help!
> 
> I am 100% not in a position to judge whether Linux needs Comprehensive
> System Accounting, nor am I able to define what the requirements for such a
> thing should be.  All I can tell from your patch is the quality of its
> implementation, and that's leaping far, far ahead of where we should be.

Linux needs something beyond what it has today, at least for the
HPC market SGI is familiar with.  We believe it will more generally
benefit Linux HPC and enterprise markets, which is one reason we've
released the whole CSA stack as open source.

> 
> We're going to need help from you, and from all the other stakeholders in
> judging how useful this feature is to Linux implementors and how well this
> implementation meets the (unknown) requirements.  See my problem?
> 
> I've cc'ed lse-tech, where enterprise folks hang out.  I would request that
> the people who are stakeholders in this feature
> 
> a) stick their hands up

We're running CSA in production on Altix (our Itanium/Linux platform)
for several years now.

> 
> b) let us know how important this kind of feature is for their users

A substantial number of our customers require it.  CSA has been
developed over the years on SGI's HPC systems in response to our
customers needs.  It's been reimplemented and opensourced for Linux,
originally as an SGI/LANL collaboration.

> c) review the offered feature set against their requirements
> 
> d) let us know how well the implementation fits that requirement and

It fits. :-)

Actually, one secondary feature on our wishlist is 'projects'.

Our customers are tied into the current CSA user interface.
However, there is lots of room for cooperation under that, particularly
in the kernel.  We can always consider a migration project as well.

John
