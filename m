Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVALSao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVALSao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVALSan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:30:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42142 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261193AbVALSae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:30:34 -0500
Date: Wed, 12 Jan 2005 13:06:12 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112150611.GB32024@logos.cnet>
References: <20050112094807.K24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112094807.K24171@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris!

On Wed, Jan 12, 2005 at 09:48:07AM -0800, Chris Wright wrote:
> This same discussion is taking place in a few forums.  Are you opposed to
> creating a security contact point for the kernel for people to contact
> with potential security issues?  This is standard operating procedure
> for many projects and complies with RFPolicy.
> 
> http://www.wiretrip.net/rfp/policy.html
> 
> Right now most things come in via 1) lkml, 2) maintainers, 3) vendor-sec.
> It would be nice to have a more centralized place for all of this
> information to help track it, make sure things don't fall through
> the cracks, and make sure of timely fix and disclosure.

I very much like the idea and I also think a "official" list of kernel security issues and 
respective fixes is very much required, since not every Linux distribution is supposed
to have kernel developers working for them, going through the whole changelogs 
looking for security issues, which is just silly.

Disclosing and bookkeeping of security issues is a job of the Linux kernel team.

Alan used to list down security fixes between each v2.2 release, v2.4 has never 
had such an official list (I'm trying to write CAN numbers on the changelogs lately), 
neither v2.6. Its not a practical thing for Linus/Andrew to do, its a lot of
work.

It would be interesting to have all developers to know about such initiative 
and have them send their security fixes to be logged and disclosed - its obviously
impossible for you to read all changes in the kernel. And have Linus/Andrew 
advocate in favour of it.

IMO such initiative needs to be known by all contributors for
it to be effective.

> In addition, I think it's worth considering keeping the current stable
> kernel version moving forward (point releases ala 2.6.x.y) for critical
> (mostly security) bugs.  If nothing else, I can provide a subset of -ac
> patches that are only that.

Yes, -ac has been playing that role. It is general consensus that 
such point releases are required. 

Linus doesnt do it because it is too much extra work him (and he is focused
on other things), glad you have stepped up.

> I volunteer to help with _all_ of the above.  It's what I'm here for.
> Use me, abuse me ;-)

You've been doing a lot of security work/auditing in the kernel for a long time, 
which fits the job position nicely.

I'm willing to help.

