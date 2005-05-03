Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVECBRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVECBRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 21:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVECBRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 21:17:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28057 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261265AbVECBRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 21:17:20 -0400
Date: Tue, 3 May 2005 02:17:44 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: jdike@addtoit.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/22] UML - Include the linker script rather than symlink it
Message-ID: <20050503011744.GC18977@parcelfarce.linux.theplanet.co.uk>
References: <200505012112.j41LC9fa016385@ccure.user-mode-linux.org> <20050502170654.248b11ea.akpm@osdl.org> <20050503002521.GA18977@parcelfarce.linux.theplanet.co.uk> <20050502174405.0c8cad31.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502174405.0c8cad31.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 05:44:05PM -0700, Andrew Morton wrote:
> 
> There's a bit of a tangle going on in arch/um/kernel/Makefile, but it's
> fairly simple stuff.
> 
> I put a rolled-up patch against 2.6.12-rc3 at
> http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 if someone wants to
> check it all.

Broken, due to missing mk_sc patch (it should go before mk_thread one;
how the hell did the latter manage to apply at all?)

> Is this all considered post-2.6.12 material?

Once all patches are in there - up to Jeff ;-)  Seriously, kbuild patchkit
is decently tested and has obviously no impact on other architectures.  So
that one is up to maintainer of architecture in question...
