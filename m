Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTKRO3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 09:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTKRO3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 09:29:07 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:13954
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262765AbTKRO3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 09:29:05 -0500
Date: Tue, 18 Nov 2003 09:28:18 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 
 Architecture
In-Reply-To: <p73brs29ycl.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.53.0311180927460.11537@montezuma.fsmlabs.com>
References: <JB3R.23s.23@gated-at.bofh.it.suse.lists.linux.kernel>
 <JWKQ.7nS.15@gated-at.bofh.it.suse.lists.linux.kernel>
 <LhtX.bs.15@gated-at.bofh.it.suse.lists.linux.kernel>
 <LhtX.bs.13@gated-at.bofh.it.suse.lists.linux.kernel>
 <m3k76qsf8i.fsf@averell.firstfloor.org.suse.lists.linux.kernel>
 <Pine.LNX.4.53.0310271603580.21953@montezuma.fsmlabs.com.suse.lists.linux.kernel>
 <p73brs29ycl.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, Andi Kleen wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:
> 
> > On Mon, 27 Oct 2003, Andi Kleen wrote:
> > 
> > > The wmb() change is not needed, unless you have an oostore CPU
> > > (x86 has ordered writes by default). It probably does not hurt
> > > neither though (I do it the same way on x86-64), but also doesn't 
> > > change anything.
> > 
> > The original intent was to fix an SMP P5 system, it oopses otherwise under 
> > load.
> 
> That doesn't make any sense. P5 doesn't support SFENCE.

I think i misparsed what you were referring to, i thought it was the patch 
with the barrier in smp_call_function().

My bad.

