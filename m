Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTE0MaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTE0MaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:30:09 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:27584 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S263458AbTE0MaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:30:06 -0400
Date: Tue, 27 May 2003 22:44:11 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 - IRQs+PCMCIA: Nobody cares! *sniff*
Message-ID: <20030527124411.GD497@zip.com.au>
References: <20030527120346.GB497@zip.com.au> <20030527134005.C16734@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527134005.C16734@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 01:40:05PM +0100, Russell King wrote:
> On Tue, May 27, 2003 at 10:03:46PM +1000, CaT wrote:
> > I think back then someone said that Russel King was working on a fix.
> 
> The deadlock-on-boot-with-card-inserted is solved and in Linus' kernel.

Cool. Didn't know if the stuff below was part of that or not.

> > irq 10: nobody cared!
> > Call Trace:
> >  [<c010a2d1>] handle_IRQ_event+0x91/0x100
> >  [<c010a2d9>] handle_IRQ_event+0x99/0x100
> >  [<c010a4f5>] do_IRQ+0xb9/0x130
> >  [<c0108f9c>] common_interrupt+0x18/0x20
> >  [<c0113236>] delay_tsc+0x12/0x1c
> >  [<c0201152>] __delay+0x12/0x18
> >  [<c02011c1>] __const_udelay+0x21/0x30
> 
> These aren't oopses.  They're reports with a call trace that someone

Yeah. I realised that baout 20 seconds after I hit 'y' to send. :)

> didn't find something to service when an interrupt occurred.  Earlier
> kernels ignored this condition.  You can safely ignore them for now,
> but at some point they do need to be cleaned up.

Cool. I shall cease to worry then. :)

Thanks. :)

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
