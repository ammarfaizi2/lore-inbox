Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUBDS6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUBDS6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:58:37 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:7942 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263625AbUBDS6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:58:35 -0500
Date: Wed, 4 Feb 2004 18:58:31 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, <torvalds@transmeta.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fb.h header fix.
In-Reply-To: <1075867994.1747.1.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402041857210.20659-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > The XFree86 fbdev server build breaks with the current fb.h. This patch 
> > >  fixes that.
> > 
> > The previous version of this patch caused the ppc64 build to fail.  Did
> > that get addressed?
> 
> Not yet, it's a ppc64 bug, I haven't had time to fix it, for some
> reason, ppc64 doesn't have readq/writeq nor __raw_ IO accessors.

This means more than the fbdev layer will break on the ppc64.
Ben you you post a patch for the ppc64 so the fbdev patch can go in?


