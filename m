Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVAMW0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVAMW0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVAMW0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:26:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:49637 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261764AbVAMWZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:25:28 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113172230.GA6162@logos.cnet>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112174203.GA691@logos.cnet>
	 <1105627541.4624.24.camel@localhost.localdomain>
	 <20050113172230.GA6162@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105651247.4624.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 21:20:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 17:22, Marcelo Tosatti wrote:
> Well the reporters, and vendorsec, have to be aware that the 
> "kernel security list" is the main discussion point of kernel security issues.

As it should be - I'd rather Linus was fixing these bugs than some of
the other stuff that comes out. The fix quality would go up markedly.

> If the embargo period is reasonable for vendors to prepare their updates and 
> do necessary QA, there should be no need for kernel issues to be coordinated 
> (and embargoed) on vendorsec anymore. Does it make sense?

vendor-sec was never intended to be a kernel security list, it became
one by necessity. Its mostly actually talking about crap like gaim,
xpdf, gaim, gaim again. Its a contact point for any security problem
related to Linux and then normally works with the authors unless they
don't want to work with us.

> The main reason for reporters to require "permission" to spread the information
> is because they want make a PR of their discovery, yes?

Sometimes. Others like CERT have set disclosure dates across many
vendors already and aren't in the PR business so much as the "this is a
linux and windows and apple bug" business. Most of those cross platform
bugs are user space but far from all. 

> In that case they should be aware that submitting to vendorsec means submitting
> to kernel security, and that means X days of embargo period.

Then if the dates don't suit them they won't submit to vendor-sec and
we'll have to set up vendor-sec-two for them or build individual
relationships which are bound to mean the small vendors suffer. We can
push them, we can ask them to report to linux-security but we can't make
them jump. 

Alan

