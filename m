Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264205AbUFRI12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264205AbUFRI12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 04:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbUFRI12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 04:27:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32394 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264205AbUFRI1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:27:25 -0400
Date: Fri, 18 Jun 2004 10:27:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618082708.GD12881@suse.de>
References: <40D232AD.4020708@opensound.com> <20040617173953.39eae56c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617173953.39eae56c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17 2004, Andrew Morton wrote:
> 4Front Technologies <dev@opensound.com> wrote:
> >
> > This is absolutely not our problem and we don't know who to contact at SuSE to fix
> > this problem. Our software works perfectly with Fedora/Debian/Gentoo/Mandrake/Redhat/etc.
> 
> Are you referring to userspace applications which fail under Suse's kernel,
> or are you referring to kernel code?
> 
> If the former then yes, this may well be a bug in the Suse kernel - please
> provide the means to reproduce it.
> 
> If the latter (your drivers don't work in Suse's kernel) then this too
> could be a bug in the Suse changes, or in your driver.  Again, more details
> would be needed to diagnose it.

The guy seems to have some personal agenda, posting specifics would ruin
his otherwise fine troll.

> I expect your distress is a little misplaced - someone somewhere has a
> silly little bug and once that's found and fixed, things will be OK.

Precisely.

> As to your broader point - yes, I too am disturbed by *any* divergence from
> a kernel.org kernel.  Because it means that there is some feature which the
> mainstream kernel is missing, or some problem which remains unresolved. 
> Especially if there are variations in user-visible features - that would be
> very bad for everyone.
> 
> Either way, each unmerged patch is a little failing which costs the users
> of the patched kernel as well as the users of the unpatched kernels.
> 
> I don't have a lot of substantiation for this, but I think the reason why
> suse are sitting on 1500 patches is a combination of:
> 
> a) They're on 2.6.5 and have included a lot of patches which are already in
>    2.6.6 and 2.6.7

Yep, at some point in a release schedule you have to stop blindly
merging patches from upstream -mm and -linus. But lots of patches are
bug fixes which were "back ported" (really just merged) from Linus or
your kernel.

And then at some point you start over, merge up, and get rid of these
(almost) thousands of patches.

> b) They shipped the kitchen sink with 2.4 and their customers still want
>    to wash the dishes in 2.6.
> 
> c) Maybe they haven't been terribly stern about throwing things away.
> 
> 
> I would like to see a little more all-round effort to reduce the variation
> between kernels, and perhaps Suse moved onto 2.6 a little later than they
> should and have a resourcing problem.  Hopefully we'll be seeing more
> patches from them soon.

A lot of the patches are already in -mm or -linus later versions. I'm
sure once crunch time is over more patches will get merged upstream, but
I do think that we have been a _lot_ better at merging with 2.6 than
previously.

The last thing anyone wants is the situation we had/have with (basically
all) 2.4 vendor kernels.

-- 
Jens Axboe

