Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbTBTPbC>; Thu, 20 Feb 2003 10:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbTBTPbB>; Thu, 20 Feb 2003 10:31:01 -0500
Received: from [202.41.99.9] ([202.41.99.9]:1488 "EHLO
	mail-relay-vsat2.ernet.in") by vger.kernel.org with ESMTP
	id <S265517AbTBTPbA>; Thu, 20 Feb 2003 10:31:00 -0500
Date: Thu, 20 Feb 2003 21:15:12 +0500 (GMT)
From: Sahani Himanshu <honeyuee@iitr.ernet.in>
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Adaptec drivers causing problem in RHL 8.0
In-Reply-To: <20030220152723.GA3146@gtf.org>
Message-ID: <Pine.GSO.4.05.10302202111580.28156-100000@iitr.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Jeff Garzik wrote:

> On Thu, Feb 20, 2003 at 08:20:13AM -0700, Justin T. Gibbs wrote:
> > > I recently installed RHL 8.0 on a SGI1200 server. The server has 
> > > "Adaptec AIC-7896 SCSI BIOS v2.20S1B1" installed.
> 
> > Those messages point to an interrupt routing problem.  The driver is
> > not able to see interrupts from the chip, so timeouts occur.  Have
> > you tries some of the various "apic/noapic" kernel options to see if
> > your interrupt routing improves?  Often switching between UP and
> > SMP kernels will change how interrupt routing is performed too.

I have tried the noapic option for the kernel without any result. However
I reloaded RHL 6.2 on the m/c, and it is working properly. By the way what
other options do I need to probe?

> 
> Indeed, these are good avenues to poke.
> 
> FWIW, on Red Hat UP kernels, the "local IO-APIC" option is not even
> compiled in.

That is surprising as the m/c is working perfectly under RHL 6.2 which is
an older release, assuming that what works perfectly for an earlier
release should work for the later release.

Still waiting for a solution.

With Best Regards
HimS


