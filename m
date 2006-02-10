Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWBJBEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWBJBEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 20:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWBJBEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 20:04:41 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:17384 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750946AbWBJBEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 20:04:41 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v22
Date: Fri, 10 Feb 2006 12:04:12 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ck list <ck@vds.kolivas.org>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>, Paul Jackson <pj@sgi.com>
References: <200602092339.49719.kernel@kolivas.org> <43EB43B9.5040001@yahoo.com.au> <200602100151.40894.kernel@kolivas.org>
In-Reply-To: <200602100151.40894.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101204.12834.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 01:51, Con Kolivas wrote:
> On Friday 10 February 2006 00:29, Nick Piggin wrote:
> > busy Con Kolivas wrote:
> > > +	struct radix_tree_root	swap_tree;	/* Lookup tree of pages */
> >
> > Umm... what is swap_tree for, exactly?
>
> To avoid ...
>
> /me looks around
>
> It's because...
>
> /me scratches head
>
> wtf..
>
> /me comes up with the answer
>
> legacy that must die

Ah now I remember. To not iterate over the whole list when removing entries 
from the swapped list.

Cheers,
Con
