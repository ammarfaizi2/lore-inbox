Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSHGBng>; Tue, 6 Aug 2002 21:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSHGBng>; Tue, 6 Aug 2002 21:43:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18565 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316599AbSHGBnf>; Tue, 6 Aug 2002 21:43:35 -0400
Date: Tue, 6 Aug 2002 21:51:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Leif Sawyer <lsawyer@gci.com>
cc: Ben Greear <greearb@candelatech.com>, abraham@2d3d.co.za,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org
Subject: RE: ethtool documentation
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31509E4BD84@berkeley.gci.com>
Message-ID: <Pine.LNX.3.95.1020806214553.26399A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Leif Sawyer wrote:

> Ben Greear responded to:
> > "Richard B. Johnson" who wrote:
> >> Because of this, there is no such thing as 'unused eeprom space'
> >> in the Ethernet Controllers. Be careful about putting this weapon
> >> in the hands of the 'public'. All you need is for one Linux Machine
> >> on a LAN to end up with the same IEEE Station Address as another
> >> on that LAN and connectivity to everything on that segment will
> >> stop. You do this once at an important site and Linux will get a
> >> very black eye.
> > 
> > Actually, any important site has some kind of failover in 
> > place, and they could very well be using this feature to provide
> > seamless MAC/IP takeover in the case of a server outtage.
> > 
> > This feature also allows bridging to work, and anyone with 
> > root priviledges can send any ethernet packet they want using
> > a raw packet socket anyway.
> 
> Absolutely.  Remember this is all about Freedoms.  Why try to take
> away the ability to do something?  Especially when it already exists
> and is very usefull.
> 
> I recently replaced a firewall "live"  by using mac-address spoofing.
> Nobody noticed anything, except for a 30-sec 'hiccup' when traffic
> "slowed down."
> 
> And really, Richard, If you want to take that argument, why would you
> want anybody to change IP's?  Because if one Linux Machine on a LAN
> ended up with the same IP of another machine on that LAN, then connectivity
> to those two machines is flakey at best.  Or if it took over the IP of
> the default GW, then all communication outside of the LAN will stop.
> And this _never happens_ in real life?  Yet we still can change IP
> addresses freely.  ( e.g., VLANs, Frame Relay DLCIs, ATM, AX.25, DecNet
> nodes, etc...)
> 

This is not about 'freedom'. This is about modifying some hardware
to make it pretend that it's something that it is not. It's completely
unlike IP addresses or anything like that. It is supposed to uniquely
identify a piece of hardware. It's like the "frequency of a radio station"
where the IP address is like the "call sign".

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

