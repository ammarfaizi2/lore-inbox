Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130548AbRAJBog>; Tue, 9 Jan 2001 20:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130575AbRAJBo0>; Tue, 9 Jan 2001 20:44:26 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:34323 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S130548AbRAJBoS>;
	Tue, 9 Jan 2001 20:44:18 -0500
Message-ID: <3A5BCD51.E5888A2C@candelatech.com>
Date: Tue, 09 Jan 2001 19:47:45 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Christopher E. Brown" <cbrown@denalics.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <Pine.LNX.4.10.10101091114590.15451-100000@borg.denalics.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher E. Brown" wrote:
> 

>         Think VLANing switch clusters.  Say 4 switches connected by
> GigE on 4 floors or in 4 separate building.  Now, across these
> switches 20 VLANS are running, with the switches enforcing VLAN
> partitioning.  The client PCs know nothing about it, as each one
> resides within a single VLAN.

That would seem to cut down broadcast packets, and generally be a good
thing!

> 
>         Now we have our Linux box with 2 x 100Mbit FD links to the
> switch cluster running 10 VLANS per interface, and an external
> DS1/SDSL/whatever connection.  We now have 20 separate zones with
> different security controls per zone, with per switchport control over
> who resided in what group.  Or even forget the routing and just
> plugging a Linux box to a companies 200VLAN setup to provide
> DHCP/whatever.
> 
>         I must say, I *hate* VLANs for this use, it is a horrible
> thing to do that wastes massive amounts of bandwidth on simulating a
> local broadcast domain across a much larger area, but oh well.  As
> long as we have stupid managers and brain dead sales persons not much
> will change.  Are there better things to do than VLAN?  YES!  Will we
> get stuck with needing VLANs in the real world?  YES!

Umm, how does using VLANs lead to wasting massive amount of bandwidth?
(You seem to be saying that by partitioning the network we make each
partition bigger??)

What are the better solutions?

And what does your dislike for sales and management have to do with
the topic at hand?



-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
