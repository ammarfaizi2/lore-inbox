Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUHGOrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUHGOrf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 10:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUHGOrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 10:47:35 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:58380 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262768AbUHGOr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 10:47:28 -0400
Date: Sat, 7 Aug 2004 15:47:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Jon Smirl <jonsmirl@yahoo.com>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Ian Romanick <idr@us.ibm.com>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: DRM function pointer work..
Message-ID: <20040807154717.C18510@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Ian Romanick <idr@us.ibm.com>,
	DRI developer's list <dri-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040806171641.14189.qmail@web14928.mail.yahoo.com> <Pine.LNX.4.58.0408070100360.13601@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408070100360.13601@skynet>; from airlied@linux.ie on Sat, Aug 07, 2004 at 01:11:21AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 01:11:21AM +0100, Dave Airlie wrote:
> fbdev only has one distribution vector - the kernel, DRM has multiple
> distribution vectors, kernel, DRI snapshots, X releases, they all contain
> their own DRM modules, also people with older kernels should be able to

which is the root problem.  Make sure the kernel is the canonical source and
all those problems magically disappear.
