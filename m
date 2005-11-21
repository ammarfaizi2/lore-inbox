Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVKURQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVKURQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVKURQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:16:20 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35856
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932390AbVKURQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:16:19 -0500
Date: Mon, 21 Nov 2005 18:16:16 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: disable tsc with seccomp
Message-ID: <20051121171616.GH14746@opteron.random>
References: <20051105134727.GF18861@opteron.random> <200511051712.09280.ak@suse.de> <20051105163134.GC14064@opteron.random> <200511051804.08306.ak@suse.de> <20051106015542.GE14064@opteron.random> <20051121164349.GE14746@opteron.random> <20051121170517.GA20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121170517.GA20775@brahms.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 06:05:17PM +0100, Andi Kleen wrote:
> On Mon, Nov 21, 2005 at 05:43:49PM +0100, Andrea Arcangeli wrote:
> > Since there was no feedback to my last post, I assume you agree, so
> > please backout the tsc disable so then I can plug the performane counter
> > disable on top of it (at zero additional runtime cost).
> 
> Sorry I don't agree.

You've the config option, turn that off on your systems, what's the
problem with that?

Or does this mean I need to ship kernels myself with covert channels
made mathematically impossible with seccomp enabled? I'd rather avoid
having to ship special kernels to run CPUShare as safely as physically
possible. My time is already too short, so I hope I won't have to take
care of this additional burden.
