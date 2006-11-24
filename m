Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934440AbWKXJqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934440AbWKXJqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934413AbWKXJqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:46:51 -0500
Received: from brick.kernel.dk ([62.242.22.158]:797 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S934440AbWKXJqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:46:50 -0500
Date: Fri, 24 Nov 2006 10:46:49 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Message-ID: <20061124094648.GA5400@kernel.dk>
References: <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com> <9a8748490611220304y5fc1b90ande7aec9a2e2b4997@mail.gmail.com> <20061122110740.GA8055@kernel.dk> <200611240052.13719.jesper.juhl@gmail.com> <20061124065209.GX4999@kernel.dk> <9a8748490611240141o4d285317h3c1e2110f515e141@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490611240141o4d285317h3c1e2110f515e141@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24 2006, Jesper Juhl wrote:
> On 24/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> >On Fri, Nov 24 2006, Jesper Juhl wrote:
> >> > Does the box survive io intensive workloads?
> >>
> >> It seems to. It does get sluggish as hell when there is lots of disk I/O 
> >but
> >> it seems to be able to survive.
> >> I'll try some more, with some IO benchmarks + various other stuff to see
> >> if I can get it to die that way.
> >
> >Just wondering if you have a marginal powersupply, perhaps.
> >
> It is a possibility, but I doubt it, since if I use a 2.6.17.x kernel
> then things are rock solid and I can't cause a lockup even if I leave
> my box building kernels in the background for days.

Since it triggers fairly quickly, any chance that you could try and
narrow it down to a specific version that breaks?

-- 
Jens Axboe

