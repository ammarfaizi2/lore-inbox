Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbUCPU2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUCPU2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:28:03 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62148 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261640AbUCPU17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:27:59 -0500
Date: Tue, 16 Mar 2004 21:27:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Ian Campbell <icampbell@arcom.com>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Do not include linux/irq.h from linux/netpoll.h
Message-ID: <20040316202746.GO27056@fs.tum.de>
References: <1079369568.19012.100.camel@icampbell-debian> <20040316001141.C29594@flint.arm.linux.org.uk> <20040316192247.A7886@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403161133430.17272@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403161133430.17272@ppc970.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 11:34:56AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 16 Mar 2004, Russell King wrote:
> > > 
> > > What are your thoughts on this?
> > 
> > So how do we solve this problem.  Should I just merge this change and
> > ask you to pull it?  I think that's rather impolite though.
> 
> I didn't apply the patch because you said it was untested ;)
> 
> I'll happily remove that irq.h include if it really doesn't do anything 
> but break things. I'd feel happier about it if somebody said it has been 
> tested, though ;)

I removed the irq.h from netpoll.h in a 2.6.5-rc1-mm1 that was compiled
with a i386 .config that compiles as much as possible statically into
the kernel.

There were no compilation problems.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

