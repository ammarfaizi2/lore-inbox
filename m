Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbULPBop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbULPBop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbULPBmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:42:07 -0500
Received: from ozlabs.org ([203.10.76.45]:47331 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262588AbULPBku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:40:50 -0500
Subject: Re: [netfilter-core] [2.6 patch] net/ipv4/netfilter/: misc
	possible cleanups
From: Rusty Russell <rusty@rustcorp.com.au>
To: Harald Welte <laforge@netfilter.org>
Cc: Adrian Bunk <bunk@stusta.de>, Netfilter Core Team <coreteam@netfilter.org>,
       netdev@oss.sgi.com,
       Netfilter development mailing list 
	<netfilter-devel@lists.netfilter.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041215090322.GA2862@sunbeam.de.gnumonks.org>
References: <20041215011931.GD12937@stusta.de>
	 <20041215090322.GA2862@sunbeam.de.gnumonks.org>
Content-Type: text/plain
Date: Thu, 16 Dec 2004 12:40:48 +1100
Message-Id: <1103161248.2200.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 10:03 +0100, Harald Welte wrote:
> On Wed, Dec 15, 2004 at 02:19:31AM +0100, Adrian Bunk wrote:
> > The patch below contains the following possible cleanups:
...
> As you might be aware, netfilter/iptables has an enormously large
> codebase (I'd say even larger than what is in the tree) in the so-called
> patch-o-matic subsystem.  The abovementioned exports facilitate those
> modulse, and A certain amount of those new modules (especially the ones
> requiring the functions above) are scheduled for mainline inclusion over
> the next couple of months.

True, but some of these cleanups are genuine.  Deleting code also
increases the coverage of the testsuite: I've put this in my patch set
and will merge them in pieces.  At the rate I work, those that are
needed in the next few months won't be deleted.  If patches are not due
to be merged in that timeframe, it'd be nice if they contained the
exports etc. that they need rather than relying on long-term unused
features of the tree.

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

