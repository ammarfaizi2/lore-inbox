Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136594AbRA1Nha>; Sun, 28 Jan 2001 08:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136506AbRA1NhV>; Sun, 28 Jan 2001 08:37:21 -0500
Received: from felix.convergence.de ([212.84.236.131]:39687 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S132290AbRA1NhL>;
	Sun, 28 Jan 2001 08:37:11 -0500
Date: Sun, 28 Jan 2001 14:37:48 +0100
From: Felix von Leitner <leitner@fefe.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
Message-ID: <20010128143748.A9767@convergence.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3A726087.764CC02E@uow.edu.au> <200101271854.VAA02845@ms2.inr.ac.ru> <3A73AF7B.6610B559@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A73AF7B.6610B559@uow.edu.au>; from andrewm@uow.edu.au on Sun, Jan 28, 2001 at 04:34:51PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Andrew Morton (andrewm@uow.edu.au):
> Conclusions:

>   For a NIC which cannot do scatter/gather/checksums, the zerocopy
>   patch makes no change in throughput in all case.

>   For a NIC which can do scatter/gather/checksums, sendfile()
>   efficiency is improved by 40% and send() efficiency is decreased by
>   10%.  The increase and decrease caused by the zerocopy patch will in
>   fact be significantly larger than these two figures, because the
>   measurements here include a constant base load caused by the device
>   driver.

What is missing here is a good authoritative web ressource that tells
people which NIC to buy.

I have a tulip NIC because a few years ago that apparently was the NIC
of choice.  It has good multicast (which is important to me), but AFAIK
it has neither scatter-gather nor hardware checksumming.

Is there such a web page already?
If not, I volunteer to create amd maintain one.

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
