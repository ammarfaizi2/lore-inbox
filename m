Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264778AbTE1Pvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbTE1Pvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:51:40 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7428 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264778AbTE1Pvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:51:38 -0400
Date: Wed, 28 May 2003 11:58:49 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ricky Beam <jfbeam@bluetronic.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
In-Reply-To: <Pine.LNX.4.44.0305271024060.6597-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1030528115243.19675A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, Linus Torvalds wrote:

> 
> On Tue, 27 May 2003, Ricky Beam wrote:
> > 
> > Count up the number of drivers that haven't been updated to the current
> > PCI, hotplug, and modules interfaces.
> 
> Tough. If people don't use them, they don't get supported. It's that easy.

Just the other day you posted strong opposition to breaking existing
binaries, how does that map with breaking existing hardware?
> 
> The thing is, these things won't change before 2.6 (or at least a 
> pre-2.6). When 2.6.0 comes out, and somebody notices that they haven't 
> bothered to try the 2.5.x series, _then_ maybe some of those odd-ball 
> drivers get fixed.
> 
> Or not. Some of them may be literally due for retirement, with users just 
> running an old kernel on old hardware.
> 
> Btw, this is nothing new. It has _always_ been the case that a lot of 
> people didn't use the latest stable kernel until it was released, and then 
> they complained because the drivers they used weren't up to spec.
> 
> 			Linus

That's clearly true, but part of the reason is that some drivers just
don't compile, so people assume it's a work in progress. And when problems
are reported they sometimes don't get fixed even when there is a
maintainer listed for a driver. Hopefully vendors will pick up the slack
for things like that and the power management issues.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

