Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVAMWxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVAMWxL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVAMWuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:50:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:49612 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261810AbVAMWrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:47:18 -0500
Date: Thu, 13 Jan 2005 14:47:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave Jones <davej@redhat.com>, Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <1105651504.4624.150.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501131442550.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net> 
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>  <20050112185133.GA10687@kroah.com>
  <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>  <20050112161227.GF32024@logos.cnet>
  <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>  <20050112174203.GA691@logos.cnet>
  <1105627541.4624.24.camel@localhost.localdomain>  <20050113194246.GC24970@beowulf.thanes.org>
  <20050113200308.GC3555@redhat.com>  <Pine.LNX.4.58.0501131206340.2310@ppc970.osdl.org>
  <1105644461.4644.102.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org>
 <1105651504.4624.150.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Alan Cox wrote:
>
> >  - _short_ embargo, for kernel-only. I obviously believe that vendor-sec 
> >    is whoring itself for security firms and vendors. I believe there would 
> >    be a place for something with stricter rules on disclosure.
> 
> Seems these two could be the same list with a bit of respect for users
> wishes and common sense.

Possibly. On the other hand, I can well imagine that the list of
subscribers is different for the two cases. The same way I refuse to have
anything to do with vendor-sec, maybe somebody else refuses to honor even
a five-day rule, but would want to be on the "no rules, but let's be clear
that we're all good guys, not gray or black-hats.

Also, especially with a hard rule, there's just less confusion, I think, 
if the two are separate. Otherwise you'd have to have strict Subject: line 
rules or something - which basically means that they are separate lists 
anyway.

But hey, it's not even clear that both are needed. With a short enough 
disclosure requirement, maybe people feel like the "five-day rule, 
possible explicitly _relaxed_ by the original submitter" is sufficient.

			Linus
