Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVALUkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVALUkg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVALUjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:39:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:32916 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261427AbVALU1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:27:15 -0500
Date: Wed, 12 Jan 2005 12:27:11 -0800
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112122711.S24171@build.pdx.osdl.net>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>; from torvalds@osdl.org on Wed, Jan 12, 2005 at 12:00:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> On Wed, 12 Jan 2005, Marcelo Tosatti wrote:
> > How you feel about having short fixed time embargo's (lets say, 3 or 4 days) ? 
> 
> Please realize that I don't have any problem with a short-term embargo per
> se, what I have problems with is the _politics_ that it causes.  For
> example, I do _not_ want this to become a
> 
>  "vendor-sec got the information five weeks ago, and decided to embargo
>   until day X, and then because they knew of the 4-day policy of the
>   kernel security list, they released it to the kernel security list on 
>   day X-4"

I agree, and in most of these cases long delay are due to things
falling through cracks or not getting adequate cycles.  Not so much
politics.

> See? That is playing politics with a security list. That's the part I 
> don't want to have anything to do with. If somebody did that to me, I'd 
> feel pissed off like hell, and I'd say "screw them".
> 
> But in the absense of politics, I'd _happily_ have a self-imposed embargo
> that is limited to some reasonable timeframe (and "reasonable" is
> definitely counted in days, not weeks. And absolutely _not_ in months,
> like apparently sometimes happens on vendor-sec).
> 
> So if the embargo time starts ticking from _first_ report, I'd personally
> be perfectly happy with a policy of, say "5 working days" (aka one week), 
> or until it was made public somewhere else.

That's more or less my take.  Timely response to reporter, timely
debugging/bug fixing and timely disclosure.

> IOW, if it was released on vendor-sec first, vendor-sec could _not_ then
> try to time the technical list (unless they do so in a very timely manner
> indeed).

What about the reverse, and informing vendors?  This is typical...project
security contact gets report, figures out bug, works with vendor-sec on
release date.  In my experience, the long cycles rarely come from that
final negotiation.  It's usually not much of a negotiation, rather a
"heads-up", "thanks".

The two goals: 1) timely response, fix, dislosure; and 2) not leaving
vendors with pants down; don't have to be mutually exclusive.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
