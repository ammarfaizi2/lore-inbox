Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbTCOSiE>; Sat, 15 Mar 2003 13:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbTCOSiE>; Sat, 15 Mar 2003 13:38:04 -0500
Received: from bitmover.com ([192.132.92.2]:38844 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261514AbTCOSiD>;
	Sat, 15 Mar 2003 13:38:03 -0500
Date: Sat, 15 Mar 2003 10:48:49 -0800
From: Larry McVoy <lm@bitmover.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030315184849.GS7275@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1047571030.5373.161.camel@passion.cambridge.redhat.com> <200303151417.h2FEHNV9002747@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303151417.h2FEHNV9002747@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 10:17:23AM -0400, Horst von Brand wrote:
> David Woodhouse <dwmw2@infradead.org> said:
> > On Thu, 2003-03-13 at 01:03, Horst von Brand wrote:
> 
> [...]
> 
> > > Wrong. Edit a header adding a new type T. Later change an existing file
> > > that already includes said header to use T. Change a function, fix most
> > > uses. Find a wrong usage later and fix it separately. Change something, fix
> > > its Documentation/ later. Note how you can come up with dependent changes
> > > that _can't_ be detected automatically.
> 
> > True. And this is the main reason I hate BitKeeper. I really don't give
> > a rat's arse about the licence -- but I object strongly to the way it
> > enforces a false ordering of changesets. 
> 
> The dependency among changes is a partial order, the sequence in which they
> were applied is one valid topological sort of that, and the only valid one
> known to the SCM. Asking the user to provide the complete dependencies is
> error prone at very best.

No kidding.  BK is draconian about it and that makes it work for the naive
users but the really smart ones have to work around the restriction.

Arch is closer to what you want, it allows out of order changesets.  You'll
find problems with that as well, in fact, a lot of problems, but it is 
what you guys _say_ you want.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
