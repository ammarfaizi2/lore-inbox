Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbTIWC4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 22:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTIWC4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 22:56:55 -0400
Received: from dp.samba.org ([66.70.73.150]:57749 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262841AbTIWC4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 22:56:55 -0400
Date: Tue, 23 Sep 2003 12:52:28 +1000
From: Anton Blanchard <anton@samba.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move slab objects to the end of the real allocation
Message-ID: <20030923025228.GA679@krispykreme>
References: <200309221733.37203.arnd@arndb.de> <3F6F23DA.9020901@colorfullife.com> <200309222240.01023.arnd@arndb.de> <3F6F6150.10808@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6F6150.10808@colorfullife.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not aware of any other restrictions, but I think s390 would be the 
> first arch beyond i386 that supports DEBUG_PAGEALLOC, so beware. One 
> important point is that kernel_map_pages() can be called from irq 
> context - I'm not sure if all archs can support that.

Its working somewhat on ppc64. (somewhat because I dont have an easy way
to read protect pages from the kernel but I can write protect them.)

Anton
