Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVFBJv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVFBJv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFBJvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:51:55 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:15253 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261349AbVFBJtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:49:51 -0400
Date: Thu, 2 Jun 2005 10:49:50 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
In-Reply-To: <429E20B6.2000907@austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0506021049270.4112@skynet>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Joel Schopp wrote:

>
> > -    struct free_area *area;
> >      struct page *buddy;
> > -
> > +
>
> ...
>
> >      }
> > +
> >      spin_unlock_irqrestore(&zone->lock, flags);
> > -    return allocated;
> > +    return count - allocated;
> >  }
> >  +
> > +
>
> Other than the very minor whitespace changes above I have nothing bad to say
> about this patch.  I think it is about time to pick in up in -mm for wider
> testing.
>

Thanks. I posted a V13 without the whitespace damage

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
