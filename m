Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265836AbUBGB2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbUBGBZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:25:42 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:63759 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265836AbUBGBXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:23:32 -0500
Date: Sat, 7 Feb 2004 01:23:29 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev sysfs support.
In-Reply-To: <20040207011916.GD4492@kroah.com>
Message-ID: <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This function will not get called until the sysfs node stops being busy,
> so it should all work properly.  But only if that fb_info structure was
> allocated dynamically, unlike all of the current fb drivers (see my
> other comment about this patch.)
> 
> So in that case, this will cause us to try to call kfree on a static
> structure :(

I plan to move every driver to framebuffer_alloc. 


