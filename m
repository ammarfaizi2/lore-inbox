Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSHFVB7>; Tue, 6 Aug 2002 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSHFVAz>; Tue, 6 Aug 2002 17:00:55 -0400
Received: from pensacola.gci.com ([205.140.80.79]:45576 "EHLO
	pensacola.gci.com") by vger.kernel.org with ESMTP
	id <S315709AbSHFVAC>; Tue, 6 Aug 2002 17:00:02 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA31509E4BD84@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Ben Greear <greearb@candelatech.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Cc: abraham@2d3d.co.za, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org
Subject: RE: ethtool documentation
Date: Tue, 6 Aug 2002 12:57:56 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear responded to:
> "Richard B. Johnson" who wrote:
>> Because of this, there is no such thing as 'unused eeprom space'
>> in the Ethernet Controllers. Be careful about putting this weapon
>> in the hands of the 'public'. All you need is for one Linux Machine
>> on a LAN to end up with the same IEEE Station Address as another
>> on that LAN and connectivity to everything on that segment will
>> stop. You do this once at an important site and Linux will get a
>> very black eye.
> 
> Actually, any important site has some kind of failover in 
> place, and they could very well be using this feature to provide
> seamless MAC/IP takeover in the case of a server outtage.
> 
> This feature also allows bridging to work, and anyone with 
> root priviledges can send any ethernet packet they want using
> a raw packet socket anyway.

Absolutely.  Remember this is all about Freedoms.  Why try to take
away the ability to do something?  Especially when it already exists
and is very usefull.

I recently replaced a firewall "live"  by using mac-address spoofing.
Nobody noticed anything, except for a 30-sec 'hiccup' when traffic
"slowed down."

And really, Richard, If you want to take that argument, why would you
want anybody to change IP's?  Because if one Linux Machine on a LAN
ended up with the same IP of another machine on that LAN, then connectivity
to those two machines is flakey at best.  Or if it took over the IP of
the default GW, then all communication outside of the LAN will stop.
And this _never happens_ in real life?  Yet we still can change IP
addresses freely.  ( e.g., VLANs, Frame Relay DLCIs, ATM, AX.25, DecNet
nodes, etc...)

