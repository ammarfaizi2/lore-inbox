Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTIWXwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTIWXwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:52:17 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:49926 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261473AbTIWXwO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:52:14 -0400
Date: Wed, 24 Sep 2003 01:50:54 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923235054.GA10435@alpha.home.local>
References: <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local> <20030923144435.GC23111@velociraptor.random> <3F706046.1000306@euronext.nl> <20030923160600.GA4161@alpha.home.local> <20030923162319.GA1269@velociraptor.random> <20030923190219.GA5997@alpha.home.local> <20030923223457.GA16314@velociraptor.random> <20030923232959.GA9734@alpha.home.local> <20030923234849.GH16314@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923234849.GH16314@velociraptor.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 01:48:49AM +0200, Andrea Arcangeli wrote:
> On Wed, Sep 24, 2003 at 01:29:59AM +0200, Willy Tarreau wrote:
> > because you obviously never felt your heart accelerate and beat very loud
> > during these operations and cannot understand why some people prefer to keep
> 
> well, I kind of remeber that ;)
> 
> So ok, that sounds a good enough argument to keep the old patch too,
> despite you may be very few people using this.

Thanks for your understanding ;-)
 
> But let's do it only in 2.4, 2.6 should have it only dynamic.
> 
> clearly if you can try to go 2.6 (possibly using a wrong .config) then
> you can risk editing the lilo/grub file as well. And with 2.6, with the
> printk rewrite that shrinks and grows the buffer, you should have no
> need of the parameter any more.

I have not tried it remotely yet, but I may adapt to a new behaviour or write
a patch :-)

Cheers,
Willy

