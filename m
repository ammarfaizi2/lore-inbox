Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVANALl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVANALl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVANAJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:09:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:27308 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261746AbVAMWCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:02:06 -0500
Date: Thu, 13 Jan 2005 14:02:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: security contact draft
Message-ID: <20050113140205.C24171@build.pdx.osdl.net>
References: <20050113125503.C469@build.pdx.osdl.net> <1105647058.4624.134.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1105647058.4624.134.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 13, 2005 at 08:10:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Iau, 2005-01-13 at 20:55, Chris Wright wrote:
> > To keep the conversation concrete, here's a pretty rough stab at
> > documenting the policy.
> 
> It's not documenting the stuff Linus seems to be talking about which is
> a public list ? Or does Linus want both ?

I got the impression that Linus was in favor of the private one,
despite his own leanings to absolute openness.  I think a public one
(lkml notwithstanding) would be great for advisory announcements.

> >  It is preferred that mail sent to the security contact is encrypted
> >  with $PUBKEY.
> 
> https:// and bugs.kernel.org ? You can make bugzilla autoprivate
> security bugs and alert people.

Yeah, I had thought about that too.  Not a real bugzilla fan, but I'm
not tied to any particular method here.

> >  well-tested or for vendor coordination.  However, we expect these delays
> >  to be short, measurable in days, not weeks or months.  As a basic default
> >  policy, we expect report to disclosure to be on the order of $NUMDAYS.
> 
> Sounds good. $NUMDAYS is going to require some debate. My gut feeling is
> 14 days is probably the right kind of target for hard stuff remembering
> how long it takes to run QA on an enterprise grade kernel. If it gets
> too short then vendors are going to disclose elsewhere for their own
> findings and only to this list when they are all ready anyway which
> takes us back to square one.
> 
> And many are probably a lot less - those nobody is going to rush out and
> build new vendor kernels for, or those that prove to be non serious can
> probably get bumped to the public list by the security officer within a
> day or two.

Yup, I think the severity and ease of exploit are part of the discussion
around disclosure timeframe.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
