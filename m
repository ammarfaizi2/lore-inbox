Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbTIMShR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTIMShR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:37:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13835
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261585AbTIMShP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:37:15 -0400
Date: Sat, 13 Sep 2003 11:19:36 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Timothy Miller <miller@techsource.com>
cc: David Schwartz <davids@webmaster.com>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: People, not GPL  [was: Re: Driver Model]
In-Reply-To: <3F62335B.9050202@techsource.com>
Message-ID: <Pine.LNX.4.10.10309131111360.16744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Sep 2003, Timothy Miller wrote:

> 
> 
> David Schwartz wrote:
> 
> > 	However, some people seem to be arguing that the GPL_ONLY symbols are in
> > fact a license enforcement technique. If that's true, then when they
> > distribute their code, they are putting additional restrictions not in the
> > GPL on it. That is a GPL violation.
> 
> Agreed.  GPL_ONLY is not a license restriction.  It is a technical issue.

Technical if and only if it did not remove the functionality of the
symbol when called.

Since it remove the ability to call and it work, creates a restriction of
usaged.  Usage being, one calls the function and it works.

I have not decided yet to expose one of the grossest example of API thieft
yet, but will do so in time.

> Binary-only modules are inherently untrustworthy (no open code review) 
> and undebuggable.  It is therefore of technical merit to restrict both 
> what they can access in the kernel (GPL_ONLY) and limit how much kernel 
> developers should have to tolerate when they're involved.

Who cares, it reports a tainted and the community says, thank you have a
nice day.

> But beyond this, there are some social issues.  If someone finds a way 
> to work around this mechanism, they are breaking things to everyone 
> else's detriment.  For a commercial entity to violate the GPL_ONLY 
> barrier is an insult to kernel developers AND to their customers who 
> will have trouble getting problems solved.

So when is the last time a business sent it problems to LKML to be
solved?  If I were a customer of such a company, I would be gone.

> So, if a company works around GPL_ONLY, are they violating the GPL 
> license?  Probably not.  Does that make it OKAY?  Probably not.

GPL_ONLY violate usage, thus it violate GPL.
Not a hard concept.
Also what if a company produces a "private gpl" product?
Open Source to customers but not to the world?

Nan, nobody would do that silly idea.

> This is like finding a way to give a user space program access to kernel 
> resources.  There are barriers put in place for a REASON because people 
> make mistakes when they write software.  If no one did, we wouldn't have 
> any need for memory protection, would we.

Stop, the laughing hurts "memory protection" "vm" ...

Cheers,

Andre

