Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135202AbRAHHDE>; Mon, 8 Jan 2001 02:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136778AbRAHHCy>; Mon, 8 Jan 2001 02:02:54 -0500
Received: from monza.monza.org ([209.102.105.34]:2058 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S135202AbRAHHCk>;
	Mon, 8 Jan 2001 02:02:40 -0500
Date: Sun, 7 Jan 2001 23:02:26 -0800
From: Tim Wright <timw@splhi.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Christian Loth <chris@gidayu.max.uni-duisburg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: DHCP Problems with 3com 3c905C Tornado
Message-ID: <20010107230226.A2074@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Andrew Morton <andrewm@uow.edu.au>,
	Christian Loth <chris@gidayu.max.uni-duisburg.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010104123139.A15097@gidayu.max.uni-duisburg.de> <3A58725F.A1E3CD37@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A58725F.A1E3CD37@uow.edu.au>; from andrewm@uow.edu.au on Mon, Jan 08, 2001 at 12:42:55AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds somewhat familiar. The pump that came with RedHat 6.2 never worked
correctly at work, but dhcpcd worked just fine (we don't have static IP
addresses, but there are fewer machines than there are addresses in the pool,
so effectively, we do :-). The odd thing is that I (mis?)understood in this
case that dhcpcd was not working either (unless I'm confusing this with a
different thread). Suffice to say that newer versions of pump seem to work
much better, at least for me.

Tim

On Mon, Jan 08, 2001 at 12:42:55AM +1100, Andrew Morton wrote:
> Christian Loth wrote:
> > 
> > Hello all,
> > 
> >   I recently installed a system with the 3c905C
> > NIC on RedHat 6.2. In our network, IP adresses
> > are granted via DHCP, although every host has
> > a fixed IP instead of a dynamic IP pool. The IP
> > is statically coupled with the MAC adresses of
> > our network.
> 
> Christian,
> 
> I was able to reproduce this.  All sorts of wierd stuff.
> 
> All the problems magically disappeared after upgrading
> to pump-0.8.6.
> 
> You wouldn't *believe* how hard it is to find a pump
> tarball, so I've put one at
> 
> 	http://www.uow.edu.au/~andrewm/pump-0.8.6.tar.gz
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
