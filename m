Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVALVEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVALVEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVALVDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:03:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:11452 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261438AbVALU52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:57:28 -0500
Date: Wed, 12 Jan 2005 12:57:17 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112205717.GA12319@kroah.com>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112122711.S24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112122711.S24171@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 12:27:11PM -0800, Chris Wright wrote:
> * Linus Torvalds (torvalds@osdl.org) wrote:
> > But in the absense of politics, I'd _happily_ have a self-imposed embargo
> > that is limited to some reasonable timeframe (and "reasonable" is
> > definitely counted in days, not weeks. And absolutely _not_ in months,
> > like apparently sometimes happens on vendor-sec).
> > 
> > So if the embargo time starts ticking from _first_ report, I'd personally
> > be perfectly happy with a policy of, say "5 working days" (aka one week), 
> > or until it was made public somewhere else.
> 
> That's more or less my take.  Timely response to reporter, timely
> debugging/bug fixing and timely disclosure.

That sounds sane to me too.

> > IOW, if it was released on vendor-sec first, vendor-sec could _not_ then
> > try to time the technical list (unless they do so in a very timely manner
> > indeed).
> 
> What about the reverse, and informing vendors?  This is typical...project
> security contact gets report, figures out bug, works with vendor-sec on
> release date.  In my experience, the long cycles rarely come from that
> final negotiation.  It's usually not much of a negotiation, rather a
> "heads-up", "thanks".

Vendors should also cc: the kernel-security list/contact at the same
time they would normally contact vendor-sec.  I don't see a problem with
that happening, and would help out the people on vendor-sec from having
to wade through a lot of linux kernel specific stuff at times.

> The two goals: 1) timely response, fix, dislosure; and 2) not leaving
> vendors with pants down; don't have to be mutually exclusive.

I agree, having pants down when you don't want them to be isn't a good
thing :)

thanks,

greg k-h
