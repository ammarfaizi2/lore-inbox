Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbTCGOSw>; Fri, 7 Mar 2003 09:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261608AbTCGOSw>; Fri, 7 Mar 2003 09:18:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31760 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261607AbTCGOSt>; Fri, 7 Mar 2003 09:18:49 -0500
Date: Fri, 7 Mar 2003 14:29:20 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Chris Dukes <pakrat@www.uk.linux.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030307142920.F17492@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Dukes <pakrat@www.uk.linux.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <1046990052.18158.121.camel@irongate.swansea.linux.org.uk> <20030306221136.GB26732@gtf.org> <20030306222546.K838@flint.arm.linux.org.uk> <1046996037.18158.142.camel@irongate.swansea.linux.org.uk> <20030306231905.M838@flint.arm.linux.org.uk> <1046996987.17718.144.camel@irongate.swansea.linux.org.uk> <20030307000816.P838@flint.arm.linux.org.uk> <20030307012905.G20725@parcelfarce.linux.theplanet.co.uk> <20030307094235.A11807@flint.arm.linux.org.uk> <20030307133812.A6676@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030307133812.A6676@parcelfarce.linux.theplanet.co.uk>; from pakrat@www.uk.linux.org on Fri, Mar 07, 2003 at 01:38:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 01:38:13PM +0000, Chris Dukes wrote:
> You are asserting aesthetics instead of benefits.  I asked about benefits.
> Specifically, what is the benefit of compact?

Think _embedded_.  Think "cost of flash chips".  Think "not everything
has a floppy disk".

> I'm sure you have a very good technical or business benefit to compact, 

I'm sorry, believe it or not, but I'm not swayed by "business benefits"
here.  Although I have my own business in the UK, we as a business are
currently involved in hardware design which has nothing to do with the
points I'm raising here.

> but those of us in the world of workstations and servers have zero clue 
> what it may be.

Indeed and understandable.

> User space solution is not the same as a solution implemented with
> multiple user space apps.

I've been working on klibc to work towards providing such a solution.
I know what it involves, and I know that this solution isn't there yet.
Also, the fundamentals of klibc have not been accepted by Linus, so we
don't even know if this is going to be a solution yet.

> > Note: I *do* agree that ipconfig.c needs to die before 2.6 but I do not
> > agree that today is the right day.
> 
> Perhaps you could explain why today is not the day.
> (ie, soon to be shipping product that requires it.  desire to see a viable
> userspace solution working before it is removed).

Just about every ARM kernel development downloads kernels via XMODEM
and the ability to bring networking up and mount a NFS-root filesystem
is by fair the easiest way to develop on *any* embedded device with
Ethernet.

I suppose you could say I have a _community_ interest here - an interest
in ensuring that the ARM community has the resources to be able to continue
using Linux.

So, while the big server people run around removing functionality they
don't need, they make other parts of the community suffer.  Is that
really what Open Source is about?  Suffering? 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
