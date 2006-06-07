Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWFGRT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWFGRT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWFGRT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:19:58 -0400
Received: from www.osadl.org ([213.239.205.134]:9429 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932349AbWFGRT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:19:58 -0400
Subject: Re: [patchset] Generic IRQ Subsystem: -V5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060607165456.GC13165@flint.arm.linux.org.uk>
References: <20060517001310.GA12877@elte.hu>
	 <20060517221536.GA13444@elte.hu> <20060519145225.GA12703@elte.hu>
	 <20060607165456.GC13165@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 19:20:29 +0200
Message-Id: <1149700829.5257.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 17:54 +0100, Russell King wrote:
> On Fri, May 19, 2006 at 04:52:25PM +0200, Ingo Molnar wrote:
> > This is Version 5 of the genirq patch-queue, against 2.6.17-rc4. The 
> > genirq patch-queue improves the generic IRQ layer to be truly generic, 
> > by adding various abstractions and features to it, without impacting 
> > existing functionality. It converts ARM, i386 and x86_64 to this new 
> > generic IRQ layer - while keeping compatibility with all the other 
> > genirq architectures too.
> > 
> > The full patch-queue can be downloaded from:
> > 
> >   http://redhat.com/~mingo/generic-irq-subsystem/
> 
> Is there an updated series?  This doesn't apply to -rc6 - it seems
> that maybe the ia64 folk merged some of the changes.

We did the latest changes against -mm. I can respin it against
2.6.16-rc6.

	tglx


