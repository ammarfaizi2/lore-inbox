Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143939AbRA1ToI>; Sun, 28 Jan 2001 14:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143968AbRA1ToD>; Sun, 28 Jan 2001 14:44:03 -0500
Received: from [63.95.87.168] ([63.95.87.168]:27404 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S143939AbRA1Tnr>;
	Sun, 28 Jan 2001 14:43:47 -0500
Date: Sun, 28 Jan 2001 14:43:45 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
Message-ID: <20010128144345.C13195@xi.linuxpower.cx>
In-Reply-To: <3A726087.764CC02E@uow.edu.au> <200101271854.VAA02845@ms2.inr.ac.ru> <3A73AF7B.6610B559@uow.edu.au> <20010128143748.A9767@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010128143748.A9767@convergence.de>; from leitner@fefe.de on Sun, Jan 28, 2001 at 02:37:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 02:37:48PM +0100, Felix von Leitner wrote:
> Thus spake Andrew Morton (andrewm@uow.edu.au):
> > Conclusions:
> 
> >   For a NIC which cannot do scatter/gather/checksums, the zerocopy
> >   patch makes no change in throughput in all case.
> 
> >   For a NIC which can do scatter/gather/checksums, sendfile()
> >   efficiency is improved by 40% and send() efficiency is decreased by
> >   10%.  The increase and decrease caused by the zerocopy patch will in
> >   fact be significantly larger than these two figures, because the
> >   measurements here include a constant base load caused by the device
> >   driver.
> 
> What is missing here is a good authoritative web ressource that tells
> people which NIC to buy.
> 
> I have a tulip NIC because a few years ago that apparently was the NIC
> of choice.  It has good multicast (which is important to me), but AFAIK
> it has neither scatter-gather nor hardware checksumming.
> 
> Is there such a web page already?
> If not, I volunteer to create amd maintain one.

Additionally, it would be useful to have some boot messages comment on the
abilities of cards. I am sick and tired of dealing with people telling me
that 'Linux performance sucks' when they keep putting Linux on systems with
pci 8139 adaptors. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
