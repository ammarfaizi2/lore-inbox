Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268003AbUHUXWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268003AbUHUXWL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 19:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUHUXWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 19:22:10 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:29194 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S268003AbUHUXWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 19:22:07 -0400
Date: Sun, 22 Aug 2004 00:22:06 +0100
From: John Levon <levon@movementarian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jbarnes@sgi.com, anton@samba.org, phil.el@wanadoo.fr
Subject: Re: [PATCH] improve OProfile on many-way systems
Message-ID: <20040821232206.GC20175@compsoc.man.ac.uk>
References: <20040821192630.GA9501@compsoc.man.ac.uk> <20040821135833.6b1774a8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821135833.6b1774a8.akpm@osdl.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1ByfBW-000E7d-VD*3DXmab6pYHw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 01:58:33PM -0700, Andrew Morton wrote:

> > Anton prompted me to get this patch merged.  It changes the core buffer
> >  sync algorithm of OProfile to avoid global locks wherever possible.
> >  Anton tested an earlier version of this patch with some success. I've
> >  lightly tested this applied against 2.6.8.1-mm3 on my two-way machine.
> 
> OK.  Oprofile isn't the most commonly tested part of the kernel.  Given
> that you've "lightly tested" it,

I hammered the patch with earlier kernel versions for some time a while
ago. But that was on a 2-way, which hardly counts as proper testing.

> how do we know when it has had sufficient testing for its swim upstream?

I thought one of the points of the mm tree was to give things some
testing first.

> Does Philippe have some test suite, perhaps?

He doesn't have access to any SMP machines at all, last I heard.

regards
john
