Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbTD1ReR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbTD1ReR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:34:17 -0400
Received: from ns.suse.de ([213.95.15.193]:61714 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261219AbTD1ReQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:34:16 -0400
Date: Mon, 28 Apr 2003 19:44:41 +0200
From: Andi Kleen <ak@suse.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Riley Williams <Riley@Williams.Name>
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030428174441.GD1068@Wotan.suse.de>
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD5AC1.7090003@us.ibm.com> <3EAD5D90.7010101@gmx.net> <3EAD61FB.30907@us.ibm.com> <3EAD6688.7060809@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAD6688.7060809@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Don't forget that highmem starts to be needed before the 4G boundary.
> > The kernel has only 1GB of virtual space (look for PAGE_OFFSET, which
> > defines it), which means that you start needing to pull all of the
> > highmem trickery before you get to the actual limits.
> 
> It seems I misunderstood the concept of highmem. I thought highmem was
> not needed on 64-bit arches. Thanks for pointing that out to me.

No, your original understandarding was correct. Highmem is not used on 64bit.

-Andi
