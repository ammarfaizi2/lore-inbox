Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWFSU7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWFSU7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWFSU7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:59:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42631 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932330AbWFSU7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:59:43 -0400
Date: Mon, 19 Jun 2006 16:59:38 -0400
From: Dave Jones <davej@redhat.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Message-ID: <20060619205938.GA8986@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com> <Pine.LNX.4.61.0606191627270.5064@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606191627270.5064@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 04:47:37PM -0400, linux-os (Dick Johnson) wrote:

 > > Why do you think we go to the bother of installing a double fault handler if
 > > we're going to reset? Why would we go to the bother of printk'ing
 > > information about the double fault if we're about to reset faster than
 > > it would get to a serial console ?
 > 
 > I don't know why you go to the bother of installing such a handler.

I even explained why in my mail.

 "The box intentionally locks up, so we have a chance to know wtf happened."

What's easier to debug: A box that just spontaneously reboots, or a box
that locks up with doublefault information on screen ?

 > Have you actually gotten it to print something? All my experience
 > with double-faults (and many with your RH Linux, BTW) result in
 > the screen going blank, the POST starting, and the machine re-booting.

No release of Red Hat Linux ever shipped with a double fault hander.
RHEL4 is the only product we sell that has it. Fedora also has it since
FC2 iirc.

 > > Your single datapoint is just that, a single datapoint.
 > > There are a number of reported cases of CPUs frying themselves.
 > > Here's one: http://www.tomshardware.com/2001/09/17/hot_spot/page4.html
 > > Google no doubt has more.
 > >
 > > Another anecdote: Upon fan failure, I once had an athlon MP *completely shatter*
 > > (as in broke in two pieces) under extreme heat.
 > >
 > > This _does_ happen.
 > 
 > Maybe it wasn't a FAN failure?

Same fan was transplanted to another box after that death, where it
was found to be as dead as the CPU & board it was previously plugged into.

Given the heat of the dead CPU, it's safe to say it wasn't operation
at time of death.

		Dave

-- 
http://www.codemonkey.org.uk
