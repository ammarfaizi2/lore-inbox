Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317445AbSFHU3A>; Sat, 8 Jun 2002 16:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317447AbSFHU27>; Sat, 8 Jun 2002 16:28:59 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:18382 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317445AbSFHU26>;
	Sat, 8 Jun 2002 16:28:58 -0400
Message-ID: <3D01307C.4090503@candelatech.com>
Date: Fri, 07 Jun 2002 15:15:24 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <3CFFB9F8.54455B6E@nortelnetworks.com> <20020606.202108.52904668.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Datagram sockets are the ones that drop data though (tcp will
deal with it via re-transmits).

I have not looked at his patch in detail, but I would welcome anything
that gets us closer to being able to account for every packet that enters
the NIC, or enters the kernel from user-space via send(to), etc...

David S. Miller wrote:

> Your idea is totally useless for non-datagram sockets.
> Only datagram sockets use the interfaces where you bump
> the counters.
> 
> I don't like the patch, nor the idea behind it, at all.
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


