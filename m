Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTIWXsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTIWXsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:48:46 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12178
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263462AbTIWXsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:48:42 -0400
Date: Wed, 24 Sep 2003 01:48:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923234849.GH16314@velociraptor.random>
References: <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local> <20030923144435.GC23111@velociraptor.random> <3F706046.1000306@euronext.nl> <20030923160600.GA4161@alpha.home.local> <20030923162319.GA1269@velociraptor.random> <20030923190219.GA5997@alpha.home.local> <20030923223457.GA16314@velociraptor.random> <20030923232959.GA9734@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923232959.GA9734@alpha.home.local>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 01:29:59AM +0200, Willy Tarreau wrote:
> because you obviously never felt your heart accelerate and beat very loud
> during these operations and cannot understand why some people prefer to keep

well, I kind of remeber that ;)

So ok, that sounds a good enough argument to keep the old patch too,
despite you may be very few people using this.

But let's do it only in 2.4, 2.6 should have it only dynamic.

clearly if you can try to go 2.6 (possibly using a wrong .config) then
you can risk editing the lilo/grub file as well. And with 2.6, with the
printk rewrite that shrinks and grows the buffer, you should have no
need of the parameter any more.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
