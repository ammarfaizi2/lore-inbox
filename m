Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264120AbRFROnv>; Mon, 18 Jun 2001 10:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264122AbRFROnl>; Mon, 18 Jun 2001 10:43:41 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:28175 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S264120AbRFROnb>;
	Mon, 18 Jun 2001 10:43:31 -0400
Date: Mon, 18 Jun 2001 16:43:22 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Pete Wyckoff <pw@osc.edu>, nick@snowman.net, Kip Macy <kmacy@netapp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
Message-ID: <20010618164322.A28377@pcep-jamie.cern.ch>
In-Reply-To: <15145.11935.992736.767777@pizda.ninka.net> <Pine.LNX.4.21.0106141739140.16013-100000@ns> <15145.12192.199302.981306@pizda.ninka.net> <20010615111213.C2245@osc.edu> <15146.11179.315190.615024@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15146.11179.315190.615024@pizda.ninka.net>; from davem@redhat.com on Fri, Jun 15, 2001 at 08:37:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Pete Wyckoff writes:
>  > We're currently working on using both processors
>  > of the Tigon in parallel.
> 
> It is my understanding that on the Tigon2, the second processor is
> only for working around hw bugs in the DMA controller of the board and
> cannot be used for other tasks.

It certainly can be used for other tasks.  At CERN we have programmed
both processors on the Tigon2 to act as a traffic generator &
measurement tool to test switches.  We use lots of cards in parallel to
drive all ports on a switch.  It's given us much more useful results
than the expensive S*******s tester.

We even went so far as to build a Tigon2 development kit for Linux, and
got about 5% better performance just from using a better version of GCC and
linker tricks.

The Tigon2 cards are wonderful because of our ability to program it
however we like, and I really hope we can build similar interesting devices
from a crop of someone's Tigon3 cards.

-- Jamie
