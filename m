Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTIMXSV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTIMXSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:18:21 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17419
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262262AbTIMXSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:18:18 -0400
Date: Sat, 13 Sep 2003 16:00:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Schwartz <davids@webmaster.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: People, not GPL  [was: Re: Driver Model]
In-Reply-To: <1063490941.9402.14.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10309131532330.16744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

Taking you at face value, as always in the past, how does one parse
between "usage"/"enforcement"?

Can a non-gpl object call, use, and it work "EXPORT_SYMBOL_GPL"?

If EXPORT_SYMBOL_GPL allows functionality, then it does not "enforce" any
license issues.  If it is called and then allowed to quietly fail or not
function unless the caller's associated LICENSE is "GPL", then it does
enforce, restrict and prevents 'functional' usage.

If this is a "NEW SYMBOL" one may have an arguement to hold.

If it is an "OLD SYMBOL", or the old one is removed and replaced with an
random new one, yet the core functionality of the operations are the same,
the intent is to break or terminate usage.

If EXPORT_SYMBOL_GPL is to be a notifier to let end-user be aware that a
binary vendor may be operating in a grey region of "derived" work, fine.
Allow it to operate but make noise.

Pretend it is doing the NOVELL thing of exceeding license count, and make
noise.

It is all to simple to bypass, and if the TAINTING issues for detection
is truly only to ignore issues from non-gpl sourced drivers, then great.

I know you have killfiled me by now, but how goes business school for the
MBA?  Does this mean you are going to quit Linux?

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sat, 13 Sep 2003, Alan Cox wrote:

> On Sad, 2003-09-13 at 22:19, David Schwartz wrote:
> >  
> > > If people put GPL_ONLY symbol exports in their code, that's their call
> > > to make, is it not? It's their code and they're free to say "well, this
> > > is my code, and if you use this symbol, I consider your stuff to be a
> > > derived work". Once again it's up to the lawyers to decide whether
> > > this has legal value or not.
> > 
> > 	If it has legal value, then it's an additional restriction.
> 
> If it has legal value in showing the work is derivative thats not an
> additional restriction. Its merely showing the intent of the author. If 
> someone creates a work and its found to be derivative and they didnt
> make it GPL compatible they get sued, thats also not an additional
> restriction its what the GPL says anyway.
> 
> That is the whole point of EXPORT_SYMBOL_GPL, it doesn't enforce
> anything and Linus was absolutely specific it should not do the
> enforcing. Its a hint and a support filter.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

