Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276483AbRJKO4J>; Thu, 11 Oct 2001 10:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276453AbRJKO4A>; Thu, 11 Oct 2001 10:56:00 -0400
Received: from colorfullife.com ([216.156.138.34]:64262 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S276457AbRJKOzs>;
	Thu, 11 Oct 2001 10:55:48 -0400
Message-ID: <3BC5B313.10444AA@colorfullife.com>
Date: Thu, 11 Oct 2001 16:56:19 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Frank van Maarseveen <fvm@altium.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 8139too: NETDEV WATCHDOG: eth0: transmit timed out
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Basic mode control register 0x0000: Auto-negotiation disabled!
>    Speed fixed at 10 mbps, half-duplex.

Do you use any user space tools to fix the link speed?
	mii-diag
	eth=0,0,<number>
	module parameter?
Could you please try what happens if you remove them.

>  Basic mode status register 0x0000 ... 0000.
>    Link status: not established.
>    Capable of <Warning! No media capabilities>.
>    Unable to perform Auto-negotiation, negotiation not complete.
>  This transceiver has no vendor identification.
>  I'm advertising 0000:
>    Advertising no additional info pages.
>    Using an unknown (non 802.3) encapsulation.
>  Link partner capability is 0000:.
>    Negotiation did not complete.
> 
What is the link partner? hub, switch, fixed 10-mbit, dual-speed hub?

--
	Manfred
