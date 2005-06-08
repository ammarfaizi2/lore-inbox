Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVFHRaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVFHRaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVFHRaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:30:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55031 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261447AbVFHR3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:29:30 -0400
Date: Wed, 8 Jun 2005 10:29:23 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: kus Kusche Klaus <kus@keba.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050608155049.GA7160@elte.hu>
Message-ID: <Pine.LNX.4.10.10506081028140.28001-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Jun 2005, Ingo Molnar wrote:

> 
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > > > i have released the -V0.7.48-00 Real-Time Preemption patch, 
> > > [snip]
> > > > be affected that much (besides possible build issues). Non-x86 arches
> > > > wont build. Some regressions might happen, so take care..
> > > 
> > > What arches are likely to work in the near future?
> > > I've seen that "Kconfig.RT" is sourced for i386, x86_64, ppc, 
> > > and mips, but not for arm.
> > > 
> > > arm is one of the platforms we are interested in, any chances?
> > 
> > I can make it work, but Ingo isn't accepting non-generic IRQ arches .. 
> > So it's pretty much on hold until someone bring ARM into the generic 
> > IRQ world.
> 
> Thomas and me already did that - i think Thomas could send a patch for 
> review?


Well, making it is one thing, getting Russell to accept it is a whole
other issue.. Are you still willing to make the RT patch a sandbox for
this?


Daniel

