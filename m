Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSHFUdf>; Tue, 6 Aug 2002 16:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSHFUdf>; Tue, 6 Aug 2002 16:33:35 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:28905 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S315708AbSHFUde>;
	Tue, 6 Aug 2002 16:33:34 -0400
Message-ID: <3D50334E.2000203@candelatech.com>
Date: Tue, 06 Aug 2002 13:36:30 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org, abraham@2d3d.co.za
Subject: Re: ethtool documentation
References: <Pine.LNX.4.33L2.0208061302200.10089-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 6 Aug 2002, Richard B. Johnson wrote:
> 
> | On Tue, 6 Aug 2002, Chris Friesen wrote:
> |
> | > "Richard B. Johnson" wrote:
> | >
> | > > Because of this, there is no such thing as 'unused eeprom space' in
> | > > the Ethernet Controllers. Be careful about putting this weapon in
> | > > the hands of the 'public'. All you need is for one Linux Machine
> | > > on a LAN to end up with the same IEEE Station Address as another
> | > > on that LAN and connectivity to everything on that segment will
> | > > stop. You do this once at an important site and Linux will get a
> | > > very black eye.

Actually, any important site has some kind of failover in place, and they
could very well be using this feature to provide seamless MAC/IP takeover
in the case of a server outtage.

This feature also allows bridging to work, and anyone with root priviledges
can send any ethernet packet they want using a raw packet socket anyway.

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


