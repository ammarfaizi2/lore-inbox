Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVALVEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVALVEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVALVDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:03:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44258 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261402AbVALUyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:54:50 -0500
Date: Wed, 12 Jan 2005 15:53:50 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112205350.GM24518@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 12:00:52PM -0800, Linus Torvalds wrote:

 > > How you feel about having short fixed time embargo's (lets say, 3 or 4 days) ? 
 > Please realize that I don't have any problem with a short-term embargo per
 > se, what I have problems with is the _politics_ that it causes.  For
 > example, I do _not_ want this to become a
 > 
 >  "vendor-sec got the information five weeks ago, and decided to embargo
 >   until day X, and then because they knew of the 4-day policy of the
 >   kernel security list, they released it to the kernel security list on 
 >   day X-4"
 > 
 > See? That is playing politics with a security list. That's the part I 
 > don't want to have anything to do with. If somebody did that to me, I'd 
 > feel pissed off like hell, and I'd say "screw them".

Who would be on the kernel security list if it's to be invite only ?
Is this just going to be a handful of folks, or do you foresee it
being the same kernel folks that are currently on vendor-sec ?

My first thought was 'Chris will forward the output of security@kernel.org
to vendor-sec, and we'll get a chance to get updates built'. But you
seem dead-set against any form of delayed disclosure, which has the
effect of catching us all with our pants down when you push out
a new kernel fixing a hole and we don't have updates ready.

At this time, those with bad intents rub their hands with glee
0wning boxes at will whilst those of us responsible for vendor
kernels run like headless chickens trying to get updates out,
which can be a pain the ass if $vendor is supporting some ancient
release which is afflicted by the same bug.

If you turned the current model upsidedown and vendor-sec learned
about issues from security@kernel.org a few days before it'd at
least give us *some* time, as opposed to just springing stuff
on us without warning.

Thoughts?

		Dave

