Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313914AbSDJWkq>; Wed, 10 Apr 2002 18:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313915AbSDJWkp>; Wed, 10 Apr 2002 18:40:45 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:57475 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313914AbSDJWkn>; Wed, 10 Apr 2002 18:40:43 -0400
Date: Wed, 10 Apr 2002 16:40:22 -0600
Message-Id: <200204102240.g3AMeMn16102@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Aviv Shavit <avivshavit@yahoo.com>, Ken Brownfield <brownfld@irridia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: vm-33, strongly recommended [Re: [2.4.17/18pre] VM and swap - it's really unusable]
In-Reply-To: <20020410023006.B6875@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
> On Tue, Apr 09, 2002 at 06:07:50PM -0600, Richard Gooch wrote:
> > Andrea Arcangeli writes:
> > > I recommend everybody to never use a 2.4 kernel without first applying
> > > this vm patch:
> > [...]
> > 
> > The way you write this makes it sound that the unpatched kernel is
> > very dangerous. Is this actually true? Or do you really just mean "the
> > patched kernel has better handling under extreme loads"?
> 
> The unpatched kernel isn't dangerous in the sense it won't destroy
> data, it won't corrupt memory and finally it won't deadlock on smp
> locks, but it can theoretically deadlock with oom and it has various
> other runtime issues starting from highmem balancing, too much
> swapping, lru list balancing, related-bhs in highmem, numa broken
> with += min etc... so IMHO it is better to _always_ use the patched
> kernel that takes care of all problems that I know of at the moment,
> plus it has further optimizations. OTOH for lots of workloads
> mainline is just fine, the deadlocks never trigger and the runtime
> behaviour is ok, but unless you are certain you don't need the
> vm-33.gz patch, I recommend to apply it.

So, in other words, 99.99% of users don't need to apply the patch.
They should, in order to have a better system, but 99.99% of them
won't notice the difference. That seems to be a more honest
recommendation than the "panic stations" alert that you posted.

Just because you want people to apply your patches, doesn't mean you
should resort to alarmist-sounding messages. Let's at least have truth
in advertising in one small corner of the world :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
