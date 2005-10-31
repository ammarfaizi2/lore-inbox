Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVJaCaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVJaCaY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVJaCaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:30:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:40344 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751211AbVJaCaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:30:23 -0500
From: Andi Kleen <ak@suse.de>
To: Bob Picco <bob.picco@hp.com>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
Date: Mon, 31 Oct 2005 04:28:49 +0100
User-Agent: KMail/1.8
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>,
       matthew.e.tolentino@intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <200510310312.18395.ak@suse.de> <20051031014003.GE6019@localhost.localdomain>
In-Reply-To: <20051031014003.GE6019@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310428.50201.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 02:40, Bob Picco wrote:
> Added Matt to cc:
> Andi Kleen wrote:	[Sun Oct 30 2005, 09:12:17PM EST]
>
> > On Monday 31 October 2005 01:17, Bob Picco wrote:
> > > This is a slightly modified patch I used on x86_64 for EXTREME testing.
> > > The original 2.6.13-rc1-mhp1 patch didn't apply cleanly against 2.6.14.
> > > It will apply with this untested patch.  The patch needs to have
> > > arch_sparse_init which is only active for SPARSEMEM. This patch was
> > > just for testing EXTREME on x86_64 NUMA and needs review.
> > >
> > > I think the bootmem allocator is being used before initialized.  This
> > > wouldn't have happened before SPARSEMEM_EXTREME became the default.
> > >
> > > If you feel my analysis is correct, I'll generate a cleaner patch and
> > > test on my 4 way.
> >
> > Ok the question is - why did nobody submit this patch in time? When
> > sparse was merged I assumed folks would actually test and maintain
> > it. But that doesn't seem to be the case? Somewhat surprising.
>
> Well I did post it on lhms mailing list. 

Fixes for code that is in mainline needs to go to the appropiate mainline 
mailing list (for x86-64 that is l-k and discuss@x86-64.org) and maintainers.

> However it's incomplete because 
> it doesn't address !NUMA. 

So i should not apply it yet?

-Andi

