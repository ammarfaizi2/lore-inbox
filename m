Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVAOALy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVAOALy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVAOALx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:11:53 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:57314 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262042AbVAOALr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:11:47 -0500
Date: Sat, 15 Jan 2005 01:11:43 +0100
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, ak@suse.de,
       tony.luck@intel.com
Subject: Re: [PATCH] swiotlb: fix gcc printk warning
Message-ID: <20050115001143.GB21578@wotan.suse.de>
References: <41E82DF0.5020600@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E82DF0.5020600@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 12:39:12PM -0800, Randy.Dunlap wrote:
> 
> swiotlb: Fix gcc printk format warning on x86_64, OK for ia64:
> arch/ia64/lib/swiotlb.c:351: warning: long unsigned int format, long 
> long unsigned int arg (arg 2)

I applied to my tree for now, thanks, although Tony will likely
want to push it.

-Andi
