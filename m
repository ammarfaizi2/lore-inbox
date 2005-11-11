Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVKKTK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVKKTK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVKKTK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:10:58 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:9691 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751068AbVKKTK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:10:57 -0500
Subject: Re: truncate_inode_pages_range patch to mainline ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: reiser@namesys.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051111110535.1a491b87.akpm@osdl.org>
References: <1131735059.25354.49.camel@localhost.localdomain>
	 <20051111110535.1a491b87.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 11:10:43 -0800
Message-Id: <1131736243.25354.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 11:05 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Hi Andrew,
> > 
> > I would like to find out, what your plans and/or concerns
> > to push
> > 
> > 	reiser4-truncate_inode_pages_range.patch
> > 
> > from your -mm tree to mainline ?
> 
> Well that's part of the reiser4 patch series.  It can be fed forward if we
> need it, of course.

Please do - if you don't have concerns with it.

> 
> > I need this for my madvise(REMOVE) work.
> 
> That's OK.
> 
> > And also, I see that 
> > madvise(REMOVE) is not in -mm2 also. Do you still
> > have concerns with it ?
> 
> I haven't looked much at the latest version yet, sorry.  The
> two-weeks-after-release window isn't a good time to be looking at new
> features, so there's quite a lot of material saved up for the
> six-week-interregnum.

There is no changes in the last version, except 1 page changelog
to include the discussions & future plans.

I am okay, as long as I am in the queue for next release. I was
hoping to get more testing in your -mm tree, in the meanwhile.

> 
> But yes, your patch still sucks ;)

I know :) 

Any suggestion on making it less sucky ? I really need this :(

Thanks,
Badari

