Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVALUCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVALUCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVALUCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:02:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:36994 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261349AbVALUA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:00:57 -0500
Date: Wed, 12 Jan 2005 12:00:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050112161227.GF32024@logos.cnet>
Message-ID: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com>
 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jan 2005, Marcelo Tosatti wrote:
> 
> How you feel about having short fixed time embargo's (lets say, 3 or 4 days) ? 

Please realize that I don't have any problem with a short-term embargo per
se, what I have problems with is the _politics_ that it causes.  For
example, I do _not_ want this to become a

 "vendor-sec got the information five weeks ago, and decided to embargo
  until day X, and then because they knew of the 4-day policy of the
  kernel security list, they released it to the kernel security list on 
  day X-4"

See? That is playing politics with a security list. That's the part I 
don't want to have anything to do with. If somebody did that to me, I'd 
feel pissed off like hell, and I'd say "screw them".

But in the absense of politics, I'd _happily_ have a self-imposed embargo
that is limited to some reasonable timeframe (and "reasonable" is
definitely counted in days, not weeks. And absolutely _not_ in months,
like apparently sometimes happens on vendor-sec).

So if the embargo time starts ticking from _first_ report, I'd personally
be perfectly happy with a policy of, say "5 working days" (aka one week), 
or until it was made public somewhere else.

IOW, if it was released on vendor-sec first, vendor-sec could _not_ then
try to time the technical list (unless they do so in a very timely manner
indeed).

I'm not saying that we'd _have_ to go public after five days. I'm saying
that after that, there would be nothing holding it back (but maybe the
technical discussion on how to _fix_ it is still on-going, and that might
make people just not announce it until they're ready).

		Linus
