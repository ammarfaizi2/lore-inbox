Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTJQSVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTJQSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:21:51 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:16318 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S263366AbTJQSVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:21:46 -0400
Date: Fri, 17 Oct 2003 13:23:43 +0000 (UTC)
From: Alex Goddard <agoddard@purdue.edu>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FBDEV 2.6.0-test7 updates.
In-Reply-To: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.58.0310171317510.4377@dust>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, James Simmons wrote:

> Here is the latest fbdev patches. Please test!!! Many new enhancements.  
> Several fixes. The patch is against 2.6.0-test7

I use the VESA framebuffer.  This patch works, and is usable, but there
are a few bugs.  The cursor is broken up evenly by four vertical lines
(two seem to be adjacent leading to a double-width line in the center of
the cursor).  Also there are fragments all over the screen that look like
a slice off the top of the cursor being left behind as the screen is
painted.  The fragments do not appear wherever actual text is rendered,
but they do show up pretty much everywhere else.  If I were aware of a way
to take a screenshot, I would, but I've done the best I can describing
what I see.

These two problems aside, framebuffer seems to behave just fine, but I
haven't tested it extensively.

-- 
Alex Goddard
agoddard at purdue.edu
