Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289631AbSAWB6u>; Tue, 22 Jan 2002 20:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289639AbSAWB6l>; Tue, 22 Jan 2002 20:58:41 -0500
Received: from h225-81.adirondack.albany.edu ([169.226.225.80]:40836 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id <S289631AbSAWB62>;
	Tue, 22 Jan 2002 20:58:28 -0500
Date: Tue, 22 Jan 2002 20:58:29 -0500
From: Justin A <justin@bouncybouncy.net>
To: Andy Carlson <naclos@swbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine timeouts
Message-ID: <20020123015829.GC835@bouncybouncy.net>
In-Reply-To: <20020122234201.GA835@bouncybouncy.net> <Pine.LNX.4.33.0201221905360.3606-100000@bigandy.naclos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201221905360.3606-100000@bigandy.naclos.org>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ahhh:)
I managed to find that driver and installed it
(http://www.viaarena.com/?PageID=60)

I transfered a 100M file to someone here via http at 1.1MB/s(according
to IE, which is usually wrong but still)

Seems to be working great now
thanks:)

I wonder if that driver was included on one of those cd's that came with
the board, I never thought to look:)

-Justin

On Tue, Jan 22, 2002 at 07:07:16PM -0600, Andy Carlson wrote:
> I had problems on a Dragon+ using the kernel via-rhine driver.  I
> started using the linxfet driver from the viahardware site.  Solved all
> my problems.  I have not tried the kernel driver since early 2.4 series.
> 
> Andy Carlson                                    |\      _,,,---,,_
> naclos@swbell.net                         ZZZzz /,`.-'`'    -.  ;-;;,_
> Cat Pics: http://andyc.dyndns.org/animal.html  |,4-  ) )-,_. ,\ (  `'-'
> St. Louis, Missouri                           '---''(_/--'  `-'\_)
> 
> 
> On Tue, 22 Jan 2002, Justin A wrote:
> 
> > I've been getting many errors due to timeouts, everything was fine while
> > I was at home, but here at school it's a major problem:
> >
> > Jan 22 18:10:00 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
> > timed out
> > Jan 22 18:10:00 bouncybouncy kernel: eth0: Transmit timed out, status
> > 0000, PHY
> > status 782d, resetting...
> > Jan 22 18:10:10 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
> > timed out
> > Jan 22 18:10:10 bouncybouncy kernel: eth0: Transmit timed out, status
> > 0000, PHY
> > status 782d, resetting...
> > Jan 22 18:10:18 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
> > timed out
> > Jan 22 18:10:18 bouncybouncy kernel: eth0: Transmit timed out, status
> > 0000, PHY
> > status 782d, resetting...
> > Jan 22 18:10:26 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
> > timed out
> > Jan 22 18:10:26 bouncybouncy kernel: eth0: Transmit timed out, status
> > 0000, PHY
> > status 782d, resetting...
> > Jan 22 18:10:34 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
> > timed out
> > Jan 22 18:10:34 bouncybouncy kernel: eth0: Transmit timed out, status
> > 0000, PHY
> > status 782d, resetting...
> >
> > Jan 22 18:10:34 bouncybouncy kernel: eth0: reset did not complete in 10
> > ms.
> >
> > once it complains about that, it stops working until I reboot.
> >
> > It seems to happen everytime a large transer is done.(apt-get updgrade
> > -d the last 3 times.)
> >
> > Is this a problem with me, or are the hubs screwy?  The hubs I'm on are
> > "smart hubs", lets just say they aren't too bright:)
> >
> > I have a soyo k7vdragon+ using 2.4.17:
> > eth0: VIA VT6102 Rhine-II at 0xe800, 00:50:2c:01:64:a9, IRQ 11.
> > eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link
> > 0021.
> >
> > CC replies...
> > -Justin
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
