Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVCIK3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVCIK3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVCIK27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:28:59 -0500
Received: from colin2.muc.de ([193.149.48.15]:50449 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262275AbVCIK2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:28:36 -0500
Date: 9 Mar 2005 11:28:30 +0100
Date: Wed, 9 Mar 2005 11:28:30 +0100
From: Andi Kleen <ak@muc.de>
To: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309102830.GA76065@muc.de>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <1110363060.6280.74.camel@laptopd505.fenrus.org> <20050309101728.A17289@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309101728.A17289@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 10:17:28AM +0000, Russell King wrote:
> On Wed, Mar 09, 2005 at 11:10:59AM +0100, Arjan van de Ven wrote:
> > On Wed, 2005-03-09 at 10:56 +0100, Andi Kleen wrote:
> > > One rule I'm missing:
> > > 
> > > - It must be accepted to mainline. 
> > > 
> > 
> > I absolutely agree with Andi on this one.
> 
> What about the case (as highlighted in previous discussions) that the
> stable tree needs a simple "dirty" fix, whereas mainline takes the
> complex "clean" fix?

That's ok, as long as the maintainers agree it's an equivalent fix

What should just be ruled out is something getting fixed in stable
and not getting fixed in mainline. And the mainline patch should
always go in first and preferably tested for a short time there.

But in general it is a judgement call: if the "big fix" is not too big
or risky I would prefer the big fix just to avoid code drift.
A custom fix for stable should be more the exception than the rule.

-Andi

