Return-Path: <linux-kernel-owner+w=401wt.eu-S932735AbWLNODc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbWLNODc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWLNODL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:03:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36710 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbWLNODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:03:08 -0500
Message-ID: <4581595C.7080508@redhat.com>
Date: Thu, 14 Dec 2006 09:02:04 -0500
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <20061214051015.GA3506@nostromo.devel.redhat.com> <20061214084820.GA29311@suse.de>
In-Reply-To: <20061214084820.GA29311@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> It's just that I'm so damn tired of this whole thing.  I'm tired of
> people thinking they have a right to violate my copyright all the time.

Pretty much every license under the sun is getting violated,
and people are getting away with it. The GPL is not special
in this regard.

> And yes, it is crap that I deal with every day due to the lovely grey
> area that is Linux kernel module licensing these days.  I have customers
> that demand we support them despite them mixing three and more different
> closed source kernel modules at once and getting upset that I have no
> way to help them out.

However, users do not like running unsupportable software
when the shit hits the fan - which it will always do with
any piece of software, eventually :)

Maybe we should just educate users and teach them to
avoid crazy unsupportable configurations and simply buy
the hardware that has open drivers available?

In the laptop space, I already try to avoid everything
non-Centrino, because chances are a closed source video
or network driver would be needed with something else[1].

Judging from how much vendor drivers tend to get improved
when they get merged upstream, I don't see how vendors
think they can get away with not merging their code upstream.

I'm not talking about this from a legal standpoint (millions
of people get away with blatantly illegal stuff every day),
but from a technical and market point of view.

Why would users buy a piece of hardware that needs a binary
only driver that's unsupportable, when they can buy a similar
piece of hardware that has a driver that's upstream and is
supported by every single Linux distribution out there?

Sure, the process of getting drivers merged upstream[2] can
take some time and effort, but the resulting improvements in
driver performance and stability are often worth it.  It's
happened more than once that the Linux kernel community's
review process turned up some opportunities for a 30% performance
improvement in a submitted driver.

Hardware companies: can you afford to miss out on the stability
and performance improvements that merging a driver upstream tends
to get?

Can you afford to miss out when your competitors are getting these
benefits?

[1] other vendors: fix your stuff, so I can recommend your hardware too!
[2] http://kernelnewbies.org/UpstreamMerge
-- 
Politics is the struggle between those who want to make their country
the best in the world, and those who believe it already is.  Each group
calls the other unpatriotic.
