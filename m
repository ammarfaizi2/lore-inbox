Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129800AbQL2BBv>; Thu, 28 Dec 2000 20:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbQL2BBl>; Thu, 28 Dec 2000 20:01:41 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:3603 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129800AbQL2BBj>; Thu, 28 Dec 2000 20:01:39 -0500
Date: Thu, 28 Dec 2000 16:30:38 -0800
To: Manfred <manfred@colorfullife.com>
Cc: david@linux.com, linux-kernel@vger.kernel.org
Subject: Re: NETDEV WATCHDOG: eth0: transmit timed out
Message-ID: <20001228163038.A13837@ferret.phonewave.net>
In-Reply-To: <3A4B234E.7A950A76@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A4B234E.7A950A76@colorfullife.com>; from manfred@colorfullife.com on Thu, Dec 28, 2000 at 12:26:06PM +0100
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 12:26:06PM +0100, Manfred wrote:
> David wrote:
> >
> > Same old story, bugger still does it. Have to set the link down/up to 
> > get it running again. 
> >
> > 00:12.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 
> > 20) 
> >
> 
> I missed your earlier mails, could you resend the details? 
> I'm interested in the output from
> 
> 	tulip-diag -m -a -f
> 
> before and after a link failure.
> 
> 
> I'm aware that the tulip drivers doesn't handle cable disconnects and
> reconnects with MII pnic cards. I have a patch for that problem, but it
> affects _all_ MII tulip cards, and thus it won't be included soon. If
> tulip-diag says "10mbps-serial", then you have run into that bug.

I have the same transmit timeout problem, but with a D-Link via rhine
board. I'm running -test10, and it seems to happen under high
(interrupt?) load with both heavy disk and network
activity. Interestingly, it appears to happen more often when the other
end of the network activity is a 10BaseT link. I'm using a Netgear
dual-speed hub.

Do you think these might be related?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
