Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVAMD0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVAMD0C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVAMD0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:26:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17320 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261270AbVAMDZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:25:52 -0500
Date: Wed, 12 Jan 2005 22:25:06 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113032506.GB1212@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 06:09:31PM -0800, Linus Torvalds wrote:

 > Yes, I think delayed disclosure is broken. I think the whole notion of 
 > "vendor update available when disclosure happens" is nothing but vendor 
 > politics, and doesn't help _users_ one whit.

The volume of traffic we as a vendor get every time an issue
makes news (and sadly even the insignificant issues seem to be
making news these days) from users wanting to know where our
updates are is a good indication that your thinking is clearly bogus.

 > The only thing it does is allow the vendor to point fingers and say "hey, we
 > have an update, now it's your problem".

I fail to see the point you're trying to make here.

 > So it's embarrassing to everybody if the kernel.org kernel has a security
 > hole for longer than vendor kernels, but at the same time, most _users_
 > run vendor kernels anyway, so maybe the current setup is the proper one,
 > and the kernel.org kernel _should_ be the last one to get the fix.  

I think the timelyness isn't the issue, the issue is making sure that
the kernel.org kernel actually does end up getting the fixes.
That 2.6.10 got out of -rc with known vulnerabilities which were
known to be fixed in 2.6.9-ac is mind-boggling.  That a 2.6.10.1
didn't follow up yet is equally so.

Part of the premise of the 'new' development model was that vendor kernels
were where people go for the 'super-stable kernel', and the kernel.org
kernel may not be quite so polished around the edges. This seems to
go against what you're saying in this thread which reads..
'kernel.org kernels might not be as stable as vendor kernels, but you're
 going to need to run it if you want security holes fixed asap'

 > Whatever. I happen to believe in openness, and vendor-sec does not. It's
 > that simple.

That openness comes at a price. I don't need to bore you with
analogies, as you know as well as I do how wide and far Linux
is deployed these days, but doing this openly is just irresponsible.

Someone malicious on getting the announcement of a new kernel.org release
gets told exactly where the hole is and how to exploit it.
All they'll need to do is find a target running a vendor kernel before
updates get deployed.  Whilst this is true to a certain degree
today, as not everyone deploys security updates in a timely manner
(some not at all), things can only get worse.

		Dave
