Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTKTEm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 23:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTKTEm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 23:42:26 -0500
Received: from holomorphy.com ([199.26.172.102]:684 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264255AbTKTEmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 23:42:22 -0500
Date: Wed, 19 Nov 2003 20:38:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
Subject: Re: Announce: ndiswrapper
Message-ID: <20031120043848.GG19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Pontus Fuchs <pof@users.sourceforge.net>
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com> <3FBC402E.6070109@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBC402E.6070109@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> We'd lose a few things, like vmware, but it's not worth the threat of
>> vendors migrating en masse to NDIS/etc. emulation layers and dropping
>> all spec publication and source drivers, leaving us entirely at the
>> mercy of BBB's (Buggy Binary Blobs) to do any io whatsoever.
>> Seriously, the binary-only business has been doing us a disservice, and
>> is threatening to do worse.

On Thu, Nov 20, 2003 at 03:16:46PM +1100, Nick Piggin wrote:
> You have to admit its good for end users though. And indirectly, what
> is good for them is good for us. Take the nvidia example: end users get
> either a binary driver or nothing. If we were somehow able to stop
> nvidia from distributing their binary driver, they would say "OK".
> I don't advocate making it easy to do non native drivers of course.

I'm not convinced it is good for end users. They _think_ they're
getting something that's supported by Linux, but are instead getting
something highly problematic that ties them to specific kernel
versions and cuts off most, if not all, avenues of support available.

It's very much a second-class flavor of open source. They dare not
change the kernel version lest the binary-only trainwreck explode.
They dare not run with the whiz-bang patches going around they're
interested in lest the binary-only trainwreck explode. It may oops
in mainline, and all they can do is wait for a tech support line to
answer. Well, they're a little better than that, they have hackers
out and about, but you're still stuck waiting for a specific small
set of individuals and lose all of the "many eyes" advantages.


-- wli
