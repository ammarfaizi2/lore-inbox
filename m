Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129439AbRBDMPP>; Sun, 4 Feb 2001 07:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbRBDMPG>; Sun, 4 Feb 2001 07:15:06 -0500
Received: from fungus.teststation.com ([212.32.186.211]:10969 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129439AbRBDMPA>; Sun, 4 Feb 2001 07:15:00 -0500
Date: Sun, 4 Feb 2001 13:14:53 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Jonathan Morton <chromi@cyberspace.org>
cc: <linux-kernel@vger.kernel.org>, ksa1 <ksa1@gmx.de>
Subject: Re: d-link dfe-530 tx (bug-report)
In-Reply-To: <l03130328b6a2de0ec77b@[192.168.239.105]>
Message-ID: <Pine.LNX.4.30.0102041127500.24217-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This sounds every much like it's related to the problems we're having with
> the card not initialising on reboot from Windows.

It's not the same problem. Here the card initializes just fine. And it 
works for a while.

The "transmit timed out" message is simply saying that we told the card to
send something but it hasn't generated an interrupt or anything allowing
the driver to know the packet was actually sent.


> What's the bets we're looking at a new revision of the chip which VIA
> haven't (publically) released documentation for yet?  I'd say they're
> pretty high...

Oh, that's known already. They haven't released any info on the older
"VT3043" chip either, afaik. And the vt86c100a.pdf document is just a
preliminary version.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
