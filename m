Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVADUbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVADUbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVADU1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:27:35 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:26893 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262135AbVADU0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:26:21 -0500
Date: Tue, 4 Jan 2005 21:17:50 +0100
From: Willy Tarreau <willy@w.ods.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104201750.GB22075@alpha.home.local>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104125738.GC2708@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 04:57:38AM -0800, William Lee Irwin III wrote:
> On Mon, Jan 03, 2005 at 02:47:27PM +0100, Adrian Bunk wrote:
> > The 2.6.9 -> 2.6.10 patch is 28 MB, and while the changes that went into 
> > 2.4 were limited since the most invasive patches were postponed for 2.5, 
> > now _all_ patches go into 2.6 .
> > Yes, -mm gives a bit more testing coverage, but it doesn't seem to be 
> > enough for this vast amount of changes.
> 
> No amount of testing coverage will ever suffice. You're trying to
> empirically establish the nonexistence of something, which is only
> possible to repudiate, and never to verify.

So how do some distro makers manage to stabilize their 'enterprise' versions,
stay on a 2.4.21 with hundreds of patches which overall seem to work pretty
well ? The distro maker I think about has quite a big crunch of the kernel
developpers, and I suspect that they do this work themselves. If they can
refrain from putting new features everyday in their employer's product, why
can't they do the same for the free version ?

Other example: look how Alan releases kernels. He posts several updates a week,
some with very few changes, some with more, but at least, people can say "this
one works for me" and stick to it for a time. Indeed, I think that if 2.6.11
would stay a year in -rc version, then Alan would release tens of 2.6.10
derivatives which would then become far more stable than what the next 2.6.11
would be.

Today, coverage is done by users who are confident in one product and agree to
test it. The best reputation the tree gets, the more users will try it, and
the more covered it will be, then the best reputation it will get, etc...

Willy

