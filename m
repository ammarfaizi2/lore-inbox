Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266255AbUBDEOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 23:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266302AbUBDEOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 23:14:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:13955 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266255AbUBDEOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 23:14:14 -0500
Subject: Re: fb.h header fix.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, torvalds@transmeta.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20040203180352.364da230.akpm@osdl.org>
References: <Pine.LNX.4.44.0402040109570.11656-100000@phoenix.infradead.org>
	 <20040203180352.364da230.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1075867994.1747.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 15:13:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 13:03, Andrew Morton wrote:
> James Simmons <jsimmons@infradead.org> wrote:
> >
> > The XFree86 fbdev server build breaks with the current fb.h. This patch 
> >  fixes that.
> 
> The previous version of this patch caused the ppc64 build to fail.  Did
> that get addressed?

Not yet, it's a ppc64 bug, I haven't had time to fix it, for some
reason, ppc64 doesn't have readq/writeq nor __raw_ IO accessors.

Ben.


