Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266015AbTGDL7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 07:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266019AbTGDL7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 07:59:20 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:62215 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266015AbTGDL7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 07:59:15 -0400
Date: Fri, 4 Jul 2003 13:13:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: jari.ruusu@pp.inet.fi, akpm@digeo.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-ID: <20030704131339.A26200@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, jari.ruusu@pp.inet.fi, akpm@digeo.com,
	akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <UTC200307041108.h64B8WE00112.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200307041108.h64B8WE00112.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Jul 04, 2003 at 01:08:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 01:08:32PM +0200, Andries.Brouwer@cwi.nl wrote:
> hch to jari:
> 
> > So get your code merged. Moaning about breaking out of tree code beeing
> > broken by changes when an in-kernel alternative eists doesn't help.
> >
> > Either try to help improving what's in the tree or shut up.
> 
> 
> Oh, Christoph - can't you just be a tiny bit more civil.

Maybe I could. But Jari has only moaned about the implementation
you posted here without explaining why or even showing numbers.

That's really, really anoying.  If he wants to improve the situation
he should post patches or at least say what part of the design or
implementation in particular he doesn't like.

I'm l33t and my code is better than your is crap and I refuse to
take make a single conpromise for code like that.  Put up or
shut up.

> Here is an ungoing process of merging crypto/loop code.
> You are perfectly aware of that - you complained about
> every single stage - the rfc patch at the start was
> too large, the whitespace in the next patch was distributed
> incorrectly, also the third part had terrible bugs - I forget,
> maybe there was a superfluous #include.

Maybe I sounded too harsh all the time, but that's not complaining
but showing problems - really tiny ones like superflous includes
or bigger ones likes a wrong layer of abstraction.  If you argue
with me that these aren't problem because of whatever (like you
did for the transfer function thing) that's fine, but saying I
shouldn't "complain" about patches is crap.   If you don't want
your code (or mine or whatever) to get better don't  post it here.

> Now that you are very aware of this ongoing effort
> of merging the loop stuff that so far lived as separate
> patches outside the kernel tree, how can you say
> "get your code merged"? That is precisely what we are
> doing right now. Slowly. Step by step.

You submitted the crypto-api based loop code, Jari has a different
implementation of which he thinks it's fairly superior and his
comments indicate he wants to maintain it out of tree.  And given
that we're in the process of merging some cryptoloop implementation
this is the worst possible attitude.  He doesn't tell us what part
of the patch you posted is wrong, he doesn't even say "stop! here's
my patch instead, it's better because a, b, c), no he says please
keep the broken hooks so my l33t out of tree implementation can
be used instead because you suck.  wonderfull.

