Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316679AbSFJGIU>; Mon, 10 Jun 2002 02:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSFJGIT>; Mon, 10 Jun 2002 02:08:19 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:23007 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S316679AbSFJGIR>;
	Mon, 10 Jun 2002 02:08:17 -0400
Message-ID: <3D044249.3030406@candelatech.com>
Date: Sun, 09 Jun 2002 23:08:09 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: mark@mark.mielke.cc, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <3D029DAF.5040006@candelatech.com>	<20020608.175108.84748597.davem@redhat.com>	<3D039D22.2010805@candelatech.com> <20020609.213440.04716391.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

>    From: Ben Greear <greearb@candelatech.com>
>    Date: Sun, 09 Jun 2002 11:23:30 -0700
>    
>    I need to account for packets on a per-session basis, where a
>    session endpoint is a UDP port.  So, knowing global protocol numbers is
>    good, but it is not very useful for the detailed accounting I
>    need.
> 
> Why can't you just disable the other UDP services, and then there is
> no question which UDP server/client is causing the drops.


I run multiple connections at once, so this is not a useful alternative.
My application is fairly unique, though people doing stuff like RTP and
other streaming UDP sessions may be interested in similar counters.


> Every argument I hear is one out of lazyness.  And that is not a


Well, that pretty much finishes this discussion I guess.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


