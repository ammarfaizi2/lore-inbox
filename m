Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbUCQAYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUCQAYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:24:13 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:61335 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261869AbUCQAYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:24:11 -0500
Date: Tue, 16 Mar 2004 16:23:25 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org,
       jbarnes@sgi.com
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040317002325.GA650537@sgi.com>
References: <20040316052256.GA647970@sgi.com> <4056A062.6040203@cyberone.com.au> <20040316072046.GA636090@sgi.com> <20040316073850.GE5320@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316073850.GE5320@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 08:38:50AM +0100, Jens Axboe wrote:
> On Mon, Mar 15 2004, Jeremy Higdon wrote:
> > > I wonder why nobody's complained about this before?
> >
> > Well, some of us have, but probably not very loudly.  I had
> > naively believed that the global unplug was gone in 2.6.
> 
> Ditching plugging at the water cooler doesn't count as complain, it
> needs to get out in the open :-). When Intel posted their patch and

I agree.  It's one of those little assumptions that one should not
make, but one ends up making anyway.  :-)  Jbarnes did a prototype
of per-queue plug/unplug a couple of years ago for LK2.4, but we
didn't see much benefit.  Obviously, we gave up too soon.

> numbers, that was the first I heard of it.

One problem we had is that the profiling tools on IA64 are
very poor, so we couldn't really tell where the problem was.

jeremy
