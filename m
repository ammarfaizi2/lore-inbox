Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSFISXm>; Sun, 9 Jun 2002 14:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSFISXl>; Sun, 9 Jun 2002 14:23:41 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:13273 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S314396AbSFISXk>;
	Sun, 9 Jun 2002 14:23:40 -0400
Message-ID: <3D039D22.2010805@candelatech.com>
Date: Sun, 09 Jun 2002 11:23:30 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: mark@mark.mielke.cc, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <20020608170511.B26821@mark.mielke.cc>	<20020608.160407.101346167.davem@redhat.com>	<3D029DAF.5040006@candelatech.com> <20020608.175108.84748597.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

>    From: Ben Greear <greearb@candelatech.com>
>    Date: Sat, 08 Jun 2002 17:13:35 -0700
>    
>    If you're talking per-socket SNMP counters, then that could work.
>    General protocol-wide counters would not help much, at least
>    in my case.
> 
> Why not?  If you know where the drops are occurring, what else
> do you need to know?


I need to account for packets on a per-session basis, where a
session endpoint is a UDP port.  So, knowing global protocol numbers is
good, but it is not very useful for the detailed accounting I
need.  I could also use per-socket TCP counters, like re-transmits,
etc.  I have not looked to see if they are already there
or not...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


