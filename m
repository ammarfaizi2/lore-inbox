Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTIJNzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 09:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTIJNzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 09:55:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54034 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263152AbTIJNzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 09:55:43 -0400
Date: Wed, 10 Sep 2003 09:46:33 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
In-Reply-To: <200309101001.h8AA1amm000407@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.3.96.1030910092250.21238E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, John Bradford wrote:

> > | Once the option of running a firewall, a hot spare firewall, a
> > | customer webserver, a hot spare customer webserver, mail server,
> > | backup mail server, and a few virtual machines for customers, all on a
> > | 1U box, why are you going to want to pay for seven or more Us in a
> > | datacentre, plus extra network hardware?
> >
> > If you plan to run anything else on your firewall, and use the same
> > machine as a hot spare for itself, I don't want you as my ISP.
> > Reliability is expensive, and what you describe is known as a single
> > point of failure.
> 
> Of course, you would be right if we were talking about current
> microcomputer architectures.  I was talking about the possibility of
> current mainframe technologies being implemented in future
> microcomputer architectures.
> 
> Today, it is perfectly acceptable, normal, and commonplace to run hot
> spares of various images on a single Z/Series box.  Infact, the
> ability to do that is often a large factor in budgeting for the
> initial investment.

Depends on the customer, and how critical the operation is to the
customer. I'm working on a backup plan for a company now, to satisfy
their "smoking hole" disaster recovery plan. You don't do that unless
your company survival depends on it, but I've helped put backup in other
countries (for a bank in Ireland), etc.

> The hardware is fault tollerant by design.  Only extreme events like a
> fire or flood at the datacentre are likely to cause downtime of the
> whole machine.  I don't consider that any less secure than a rack of
> small servers.

And power failure, loss of ISP connectivity, loss of phone service...
As said originally, reliability is *hard* and *expensive* to do right.

> Different images running in their own LPARs, or under Z/Vm are
> separated from each other.  Assessments of their isolation have been
> done, and ratings are available.
> 
> You absolutely _can_ use the same physical hardware to run a hot
> spare, and protect yourself against software failiures.  A process can
> monitor the virtual machine, and switch to the hot spare if it fails.
> 
> Add to that the fact that physical LAN cabling is reduced.  The amount
> of network hardware is also reduced.  That adds to reliability.

For totally redundant equipment the probability of having some failure
goes up, the probability of total failure (unavailability) goes down.
"You pays your money and you takes your choice."

Actually we were talking about HT, or so it seems looking at the past
items, and if you get a failure of one sibling I have to believe that
other CPUs on the same chip are more likely to fail than those not
sharing the same cooling, power supply, cache memory, and die. I bet
you don't have numbers either, feel free to share if you do.

This would be a good topic for comp.arch, it's getting a bit OT here.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

