Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVAMVK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVAMVK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVAMVIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:08:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:6635 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261688AbVAMVES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:04:18 -0500
Date: Thu, 13 Jan 2005 13:03:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave Jones <davej@redhat.com>, Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <1105644461.4644.102.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net> 
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>  <20050112185133.GA10687@kroah.com>
  <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>  <20050112161227.GF32024@logos.cnet>
  <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>  <20050112174203.GA691@logos.cnet>
  <1105627541.4624.24.camel@localhost.localdomain>  <20050113194246.GC24970@beowulf.thanes.org>
  <20050113200308.GC3555@redhat.com>  <Pine.LNX.4.58.0501131206340.2310@ppc970.osdl.org>
 <1105644461.4644.102.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Alan Cox wrote:
> 
> I'm all for an open list too. Its currently called linux-kernel. Its
> full of such reports, and most of them are about new code or trivial
> holes where secrecy is pointless. Having an open linux-security list so
> they don't get missed as the grsecurity stuff did (and until I got fed
> up of waiting the coverity stuff did) would help because it would make
> sure that it didn't get buried in the noise.

Yes. But I know people send private emails because they don't want to 
create a scare, so I think we actually have several levels of lists:

 - totally open: linux-kernel, or an alternative with lower noise

   We've kind of got this, but things get lost in the noise, and "white 
   hat" people don't like feeling guilty about announcing things.

 - no embargo, no rules, but "private" in the sense that it's supposed to 
   be for kernel developers only or at least people who won't take 
   advantage of it.

   _I_ think this is the one that makes sense. No hard rules, but private 
   enough that people won't feel _guilty_ about reporting problems. Right 
   now I sometimes get private email from people who don't want to point
   out some local DoS or similar, and that can certainly get lost in the
   flow.

 - _short_ embargo, for kernel-only. I obviously believe that vendor-sec 
   is whoring itself for security firms and vendors. I believe there would 
   be a place for something with stricter rules on disclosure.

 - vendor-sec. The place where you can play any kind of games you want.

It's not a black-and-white thing. I refuse to believe that most security 
problems are found by people without any morals. I believe that somewhere 
in the middle is where most people feel most comfortable.

		Linus
