Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUHUX4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUHUX4B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 19:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUHUX4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 19:56:01 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:40465 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261602AbUHUXz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 19:55:56 -0400
Date: Sun, 22 Aug 2004 00:55:56 +0100
From: John Levon <levon@movementarian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jbarnes@sgi.com, anton@samba.org, phil.el@wanadoo.fr
Subject: Re: [PATCH] improve OProfile on many-way systems
Message-ID: <20040821235556.GA22619@compsoc.man.ac.uk>
References: <20040821192630.GA9501@compsoc.man.ac.uk> <20040821135833.6b1774a8.akpm@osdl.org> <20040821232206.GC20175@compsoc.man.ac.uk> <20040821163628.10cfa049.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821163628.10cfa049.akpm@osdl.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1ByfiG-000HyD-6n*tJljmT3NoG.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 04:36:28PM -0700, Andrew Morton wrote:

> Well yes, but it's not magic.

Absolutely. But since the vast majority of the bugs in oprofile kernel
code are either identified or reported by kernel developers, it's really
that audience that need to do testing beyond what I'm outfitted for.

For example a while ago wli walked right into an obvious bug on one of
his machines that hadn't shown up during /any/ of my testing since the
code was merged.

> One of my mental checkpoints before sending a patch to Linus is "has this
> been sufficiently tested".  I don't know how to answer that in this case.

Me neither. It would certainly be great to have a decent regression test
suite for OProfile, but I don't have one other than the usual by-hand
testing I do. Isn't there some STP thing or something at OSDL we can
get people to try?

> In fact I don't know how to answer that in a _lot_ of cases, but if I know
> that people are using the feature in anger and we're sufficiently early in
> the 2.6.x cycle then I'll assume that regressions will be picked up.

I must admit I'm still not clear on when the equivalent of "early in the
2.6.x cycle" is going to happen again... I have no idea when, if ever,
call-graph OProfile would be suitable to merge.

> Anyway.  My question was mainly a prod in the antonward direction ;)

That'd be handy certainly...

regards
john
