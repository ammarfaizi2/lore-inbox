Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbRHAQq1>; Wed, 1 Aug 2001 12:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267514AbRHAQqH>; Wed, 1 Aug 2001 12:46:07 -0400
Received: from home.paris.trader.com ([195.68.19.162]:26793 "EHLO
	smtp-gw.netclub.com") by vger.kernel.org with ESMTP
	id <S267512AbRHAQqD>; Wed, 1 Aug 2001 12:46:03 -0400
Message-ID: <3B683237.641478BE@trader.com>
Date: Wed, 01 Aug 2001 18:45:43 +0200
From: joseph.bueno@trader.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-5mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
        Thomas Zehetbauer <thomasz@hostmaster.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tulip driver still broken
In-Reply-To: <20010731001907.A21982@hostmaster.org> <3B66B13B.28BD0324@nortelnetworks.com> <3B682593.AB3D143C@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> Chris Friesen wrote:
> >
> > Thomas Zehetbauer wrote:
> > >
> > > My genuine digital network interface card ceased to work with the tulip
> > > driver contained in kernel revisions >= 2.4.4 and the development driver from
> > > sourceforge.net.
> >
> > How is the sourceforge driver different than the one at www.scyld.com?
> >
> 
> Becker (Scyld) has only recently gotten his drivers to even compile
> on 2.4 kernel, and they are still beta quality for 2.4, evidently.
> 
> There seem to be attempts to keep the drivers in sync, functionally,
> but the architectures have diverged quite a lot...
> 
> Ben
> 
> --
> Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

Hi,

I am currently using a Xircom Ethernet adapter (tulip_cb module) with a
2.4.5 kernel.

The only way I have found to make it work is to turn on promiscuous mode
(with 'tcpdump -i eth0 -n > /dev/null') after bootup. I can turn it off
after a few minutes without problem. 

I don't know if tulip driver I am using has been patched since I haven't
compiled this 2.4.5 kernel myself. Here is driver bootup information:

tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov (modified by danilo@cs.uni-magdeburg.de for XIRCOM CBE, fixed by Doug Ledford)
eth0: Xircom Cardbus Adapter (DEC 21143 compatible mode) rev 3 at 0x200, 00:10:A4:C0:2A:30, IRQ 9.
eth0:  MII transceiver #0 config 3100 status 7809 advertising 01e1.

Hope this helps
Regards
--
Joseph Bueno
