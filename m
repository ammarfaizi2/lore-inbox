Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVAMWo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVAMWo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVAMWme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:42:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:8905 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261801AbVAMWln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:41:43 -0500
Date: Thu, 13 Jan 2005 14:41:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Arjan van de Ven <arjan@infradead.org>, grendel@caudium.net,
       Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <1105650940.5193.141.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501131433210.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net> 
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>  <20050112185133.GA10687@kroah.com>
  <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>  <20050112161227.GF32024@logos.cnet>
  <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>  <20050112174203.GA691@logos.cnet>
  <1105627541.4624.24.camel@localhost.localdomain>  <20050113194246.GC24970@beowulf.thanes.org>
  <20050113115004.Z24171@build.pdx.osdl.net>  <20050113202905.GD24970@beowulf.thanes.org>
  <1105645267.4644.112.camel@localhost.localdomain> 
 <1105649837.6031.54.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.58.0501131307430.2310@ppc970.osdl.org>
 <1105650940.5193.141.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Alan Cox wrote:
>
> On Iau, 2005-01-13 at 21:22, Linus Torvalds wrote:
> > Are there advantages and upsides? Yes. Are there disadvantages?  
> > Indubitably. And anybody who disregards the disadvantages as "inevitable"
> > is not really interested in fixing the game.
> 
> So the next time I find a remote root hole I should post an exploit
> example targetting kernel.org to the linux-kernel list ? Now where are
> you going to publish the fix - bk is down, kernel.org is down ...
> 
> Disclosre isn't quite as simple as you'd like.

This is like saying "somebody will do the bad thing, it might as well be 
me". I don't believe that is a basis for doing things right.

First off, I've tried to make it clear that while I believe in openness, 
my beliefs are not exclusive to anybody elses beliefs. I'd rather see 
shades of gray than absolute black-and-white.

Secondly, I'd much rather have the mindset where we try to minimize the
likelihood of a catastrophic failure. That includes having many
_different_ ways of gettign things out: Bk, tar-balls, email. Diversity is
a _fundamental_ security strength. It also includes having diversity in 
other areas, ie multiple architectures.

I see vendor-sec as trying to treat the symptoms. It's a "take two
aspirins, call me in the morning". And you seem to not even want to
discuss treating the disease - and vendor-sec is PART of the disease. It's
the drug that people get addicted to when they decided to treat the
symptoms.

I think Linux - just by the source being open - has one real treatmeant to 
one fundamental -cause- of insecurity, namely "we don't care, and we'll 
put our heads in the sane". Open source just doesn't allow that mentality.

And similarly, I think truly open disclosure is another fundamental 
-treatment-, in that it doesn't _allow_ the mentality that vendor-sec 
tends to instill in people.  Well, maybe not "treatment" per se: it's more 
like admitting you have a problem.

It's like alcoholism. Admitting you have a problem is the first step. 
vendor-sec is the band-aid that allows you to try to ignore the problem 
("I can handle it - I could stop any day").

		Linus
