Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWFIQEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWFIQEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWFIQEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:04:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030252AbWFIQEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:04:50 -0400
Date: Fri, 9 Jun 2006 09:01:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       cmm@us.ibm.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC 0/13] extents and 48bit ext3
In-Reply-To: <448997FA.50109@garzik.org>
Message-ID: <Pine.LNX.4.64.0606090859150.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Jeff Garzik wrote:
>
> Linus Torvalds wrote:
> > 
> > On Fri, 9 Jun 2006, Jeff Garzik wrote:
> > > Overall, I'm surprised that ext3 developers don't see any of the problems
> > > related to progressive, stealth filesystem upgrades.
> > 
> > Hey, they're used to it - they've been doing it for a long time.
> 
> Agreed, but my argument is that extents are a Big Deal.

I'm not arguing against you - I'm arguing with you.

I just tried to explain what you saw as "surprising" - the fact that ext3 
developers don't see this as a problem at all. They don't see it as a 
problem, because it's how they have always worked, since before ext3 was 
ext3, and it was just a crazy extension to ext2.

And yes, it's a serious problem. Ext3 is pretty damn messy. It's not as 
messy as some, but it sure has potential.

		Linus
