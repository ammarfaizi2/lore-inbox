Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275999AbRI1KlM>; Fri, 28 Sep 2001 06:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276001AbRI1KlC>; Fri, 28 Sep 2001 06:41:02 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:53223 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S275999AbRI1Kkr>;
	Fri, 28 Sep 2001 06:40:47 -0400
Date: Fri, 28 Sep 2001 12:40:32 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to debug PCI issues?
In-Reply-To: <3BB3CFFA.F9021469@candelatech.com>
Message-ID: <Pine.LNX.4.21.0109281239040.26852-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, Ben Greear wrote:

> I'm working with a TYAN Tomcat board (i815, Ghz CPU).  It's in a 1U
> machine with a butterfly riser so that I get two riser connections to
> one PCI slot.  When I put Intel EEPRO nics in each slot, I can pass
> 30Mbps of traffic on each NIC without dropping a single packet
> (In two days of running).
> 
> If I run 20Mbps on one of the DLINK ports, I'm fine, but if I run 10Mbps
> on two of the DLINK ports, I start seeing dropped packets on every
> interface, and port errors like RX-FIFO.

If I run traffic out one port I can get 100Mbit but if I try it with two
ports at the same time I cet about 20Mbit per port at best. And I also get
a _lot_ of errors but mostly carrier-errors.

> So, I'm thinking that the DLINK NIC must be screwing up the PCI
> bus somehow when more than one of it's interfaces is passing any
> significant traffic.  I have been able to run 10Mbps on all 8 ports
> of two DLINKs on an Intel EEA2 (i815) board, so I suspect the MB.
> 
> Does anyone have any ideas how to go about trouble-shooting this
> farther?
> 
> Thanks,
> Ben
> 
> -- 
> Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

