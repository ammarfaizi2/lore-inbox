Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267665AbUHJTBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267665AbUHJTBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267634AbUHJSy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:54:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49819 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267645AbUHJSx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:53:29 -0400
Date: Tue, 10 Aug 2004 20:53:28 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: jbglaw@lug-owl.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810185327.GI19391@suse.de>
References: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de> <20040810164947.7f363529.skraw@ithnet.com> <20040810152458.GA1127@lug-owl.de> <20040810153333.GF13369@suse.de> <20040810162951.GC1127@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810162951.GC1127@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(don't trim CC lists of people you are talking to! it's rude and I
usually wont see your mail for days)

On Tue, Aug 10 2004, Jan-Benedict Glaw wrote:
> On Tue, 2004-08-10 17:33:34 +0200, Jens Axboe <axboe@suse.de>
> wrote in message <20040810153333.GF13369@suse.de>:
> 
> > Don't be naive. How do you discuss changes with him? The one patch I did
> > create against the SUSE cdrecord for the one shipped with SL9.1 adds a
> > note to use ATA over ATAPI since that is preferred, and it kills the
> > silly open-by-devname warnings that are extremely confusing to users. I
> > did send that back to Joerg, to no avail.
> 
> Look at lkml. For sure, you'll find a good number of examples of really
> small (and not really intrusive/important/...) changes that took more
> than a dozen emails to discuss (and probably to not come to an end at
> all).  Right, I think distro's people should go through all that for
> every single change, even while continueing to work on that. Patch

I agree. But time isn't divided evenly across the year, if you've ever
worked on a project you know there's a crunch time close to release
where you don't have time to do that. You only have time to fix things.
I'm not saying that's a good thing, but it happens. Then later you have
to go and push some of that stuff out, it's the individual package
maintainers duty to do so.

> > > While they (and any other distro's people and anybody else) may
> > > actually hack the code to no end, I consider it being good habit to
> > 
> > By far the largest modification is dvd support, which we of course need
> > to ship. The rest is really minor stuff.
> 
> What's more important to whom? First ship the feature, or first getting
> consens with the initial author? Exactly--there are two answers:(

If you had followed this thread at all, you'd know that in this case we
could either add the feature or spend 100% of the time being sucked into
the black hole of email writing that is Joerg.

Maybe you should consider why _every_ distro adds that patch? It's not a
new patch, it's been around for years. It's not one single distro
"forking" the code base, it's basically the same thing we ship.

-- 
Jens Axboe

