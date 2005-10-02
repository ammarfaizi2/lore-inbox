Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVJBRNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVJBRNj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 13:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVJBRNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 13:13:39 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23772 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751130AbVJBRNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 13:13:38 -0400
Date: Sun, 2 Oct 2005 10:13:19 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: akpm@osdl.org, reuben-lkml@reub.net, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, rohit.seth@intel.com
Subject: Re: 2.6.14-rc2-mm1 (Oops, possibly Netfilter related?)
Message-Id: <20051002101319.659afcde.pj@sgi.com>
In-Reply-To: <925820000.1127847556@flay>
References: <20050921222839.76c53ba1.akpm@osdl.org>
	<4338F136.1020404@reub.net>
	<20050927004410.29ab9c03.akpm@osdl.org>
	<925820000.1127847556@flay>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin, responding to Andrew:
> > I've dropped that patch.  Joel Schopp is working on Mel Gorman's patches
> > which address fragmentation at this level.  If that code gets there then we
> > can take another look at
> > mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch.
> 
> Me no understand. We're going to deliberately cause fragmentation in order
> to defragment it again later ???

I thought that the patches of Mel Gorman and Joel Schopp were reducing
fragmentation, not causing it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
