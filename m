Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTKTFSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 00:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbTKTFSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 00:18:44 -0500
Received: from holomorphy.com ([199.26.172.102]:8108 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261473AbTKTFSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 00:18:42 -0500
Date: Wed, 19 Nov 2003 21:12:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
Subject: Re: Announce: ndiswrapper
Message-ID: <20031120051211.GE22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Pontus Fuchs <pof@users.sourceforge.net>
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com> <3FBC402E.6070109@cyberone.com.au> <20031120043848.GG19856@holomorphy.com> <3FBC4A42.8010806@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBC4A42.8010806@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> I'm not convinced it is good for end users. They _think_ they're
>> getting something that's supported by Linux, but are instead getting
>> something highly problematic that ties them to specific kernel
>> versions and cuts off most, if not all, avenues of support available.

On Thu, Nov 20, 2003 at 03:59:46PM +1100, Nick Piggin wrote:
> Well what they get is hardware accelerated 3d graphics under Linux.
> If they didn't need 3d, they can use the open source drivers.
> If someone downloads and installs the drivers themselves, they should
> know enough to contact nvidia for support (I think nvidia have been
> pretty good). Others will contact their ditro support.

"cuts off most, if not all, avenues of support available" == any and
all problems with the things around are untraceable. We won't touch
tainted bugreports and rightly so. And nvidia isn't supporting the
whole kernel.


On Thu, Nov 20, 2003 at 03:59:46PM +1100, Nick Piggin wrote:
> There might be a problem where they percieve that Linux is unstable
> while it is actually binary drivers.

Yes, that's one I'm very concerned about.


William Lee Irwin III wrote:
>> It's very much a second-class flavor of open source. They dare not
>> change the kernel version lest the binary-only trainwreck explode.
>> They dare not run with the whiz-bang patches going around they're
>> interested in lest the binary-only trainwreck explode. It may oops
>> in mainline, and all they can do is wait for a tech support line to
>> answer. Well, they're a little better than that, they have hackers
>> out and about, but you're still stuck waiting for a specific small
>> set of individuals and lose all of the "many eyes" advantages.

On Thu, Nov 20, 2003 at 03:59:46PM +1100, Nick Piggin wrote:
> I must say that I've been using the same nvidia drivers on my desktop
> system for maybe a year, and never had a crash including going through
> countless versions of 2.5/6. True you need to recompile the intermediate
> layer, but then, nobody who knows less than me will know or care about
> kernel versions. Their distro will upgrade kernel+drivers if needed, and
> presumably the distro has done some sort of testing / QA.

They're rather sensitive to VM changes, and I've had people with
significantly less know-how than either of us come back after trying VM
patches in combination with nvidia stuff report things ranging from
oopsen, to reboots, to fs corruption. The insulation layers are only
partially effective at best. And end-users are fiddling with whiz bang
patches for their kernels and upgrading versions by means other than
distros. Heck, the distros aren't even shipping 2.6, and they're
running 2.6 plus patches.

And besides, nvidia is really just the most commonly reported issue due
to the hordes of end users, there are many other offenders on this
front (e.g. certain FC drivers, and apparently some wireless drivers).


-- wli
