Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVHWUKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVHWUKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVHWUKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:10:06 -0400
Received: from web33310.mail.mud.yahoo.com ([68.142.206.125]:27021 "HELO
	web33310.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932362AbVHWUKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:10:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YICoQ0o2jmvSeygZ+55EOK4JxssK4vLIGMYysVQ9F3jV0MjzRHDwJHNma/wczlWxFl8AO1HAZKS7yucA6SS9bt17KeBnjrbhKCqhwz2VqsYJeADRhzQzZe7ZFr1LnsQpgT9r2WLNcVH7GpeQLLlTrsQ6XO1hhvxf5gJ3fiR7czM=  ;
Message-ID: <20050823201004.77101.qmail@web33310.mail.mud.yahoo.com>
Date: Tue, 23 Aug 2005 13:10:04 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Sven-Thorsten Dietrich <sven@mvista.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <1124820134.15265.30.camel@imap.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Sven-Thorsten Dietrich <sven@mvista.com>
wrote:

> On Tue, 2005-08-23 at 10:10 -0700, Danial Thom
> wrote:
> > 
> 
> > > >Ok, well you'll have to explain this one:
> > > >
> > > >"Low latency comes at the cost of
> decreased
> > > >throughput - can't have both"
> > > >  
> > > >
> > > Configuring "preempt" gives lower latency,
> > > because then
> > > almost anything can be interrupted
> (preempted).
> > >  You can then
> > > get very quick responses to some things,
> i.e.
> > > interrupts and such.
> > 
> > I think part of the problem is the continued
> > misuse of the word "latency". Latency, in
> > language terms, means "unexplained delay".
> 
> latency
> 
> n 
> 1: (computer science) the time it takes for a
> specific block of data on
> a data track to rotate around to the read/write
> head [syn: rotational
> latency] 
> 2: the time that elapses between a stimulus and
> the response to it [syn:
> reaction time, response time, latent period] 
> 3: the state of being not yet evident or active
> 
> No apparent references to "unexplained" in
> association with the word
> latency.

Teaching English is not my thing, but latent
means "dormant", which means doing nothing. So
the time it takes to perform a task is not
latency. Its the time it really takes compared to
the time it ought to take if there was no
overhead. If you have a perfect implementation
then you have no latency. Your definition implies
that there is no way to have zero latency, which
is just wrong.

I've seen computer dictionaries that define
latency as the time it takes to get a response.
That would mean a network switch's latency is
different with different sized packets, which is
just plain stupid. 

None of this is helpful, but since no one has
been able to tell me how to tune it to provide
absolute priority to the network stack I'll
assume it can't be done.

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
