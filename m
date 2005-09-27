Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVI0S7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVI0S7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVI0S7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:59:20 -0400
Received: from dvhart.com ([64.146.134.43]:12941 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965046AbVI0S7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:59:19 -0400
Date: Tue, 27 Sep 2005 11:59:16 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: 2.6.14-rc2-mm1 (Oops, possibly Netfilter related?)
Message-ID: <925820000.1127847556@flay>
In-Reply-To: <20050927004410.29ab9c03.akpm@osdl.org>
References: <20050921222839.76c53ba1.akpm@osdl.org><4338F136.1020404@reub.net> <20050927004410.29ab9c03.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, this is simply a warning - the kernel ran out of 1-order pages in the
> page allocator.  There have been several reports of this after
> mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch was merged,
> which was rather expected.
> 
> I've dropped that patch.  Joel Schopp is working on Mel Gorman's patches
> which address fragmentation at this level.  If that code gets there then we
> can take another look at
> mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch.

Me no understand. We're going to deliberately cause fragmentation in order
to defragment it again later ???

M.

