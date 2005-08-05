Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVHEVzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVHEVzD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbVHEVxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:53:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:56789 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261798AbVHEVvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:51:23 -0400
Date: Fri, 5 Aug 2005 23:51:18 +0200
From: Andi Kleen <ak@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andi Kleen <ak@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       John B?ckstrand <sandos@home.se>, davem@davemloft.net
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050805215118.GE8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain> <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain> <20050805200156.GF7425@waste.org> <20050805212610.GA8266@wotan.suse.de> <20050805214224.GW8074@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805214224.GW8074@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If that was the policy it would be a quite dumb one and make netpoll
> > totally unsuitable for production use. I hope it is not.
> 
> Suggest you rip __GFP_NOFAIL out of JBD before complaining about this.

So you're suggesting we should become as bad at handling networking
errors as we are at handling IO errors?  

> > Dave, can you please apply the timeout patch anyways?
> 
> Yes, let's go right over the maintainer's objections almost
> immediately after he chimes into the thread. I'll spare the list the
> colorful language this inspires.

Sure when the maintainer has a unreasonable position on something
I think that's justified. Yours in this case is clearly unreasonable.

-Andi
