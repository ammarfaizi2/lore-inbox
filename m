Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270280AbRHHCyj>; Tue, 7 Aug 2001 22:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270281AbRHHCy3>; Tue, 7 Aug 2001 22:54:29 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:37604 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S270280AbRHHCyR>;
	Tue, 7 Aug 2001 22:54:17 -0400
Message-ID: <3B70A9E1.E9D1F48C@candelatech.com>
Date: Tue, 07 Aug 2001 19:54:25 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stuart Duncan <sety@perth.wni.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ARP's frustrating behavior
In-Reply-To: <5.1.0.14.0.20010808094513.00ab72c8@mailhost> <5.1.0.14.0.20010808103510.00aafbb0@mailhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Duncan wrote:
> 
> >Evidently, this is considered a feature.  However, to turn it off:
> >echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
> 
> I've tried this and it doesn't work.  I understand that arp_filter uses
> routing tables to determine which interfaces should respond to ARP
> queries.  In my case, both interfaces are on the same network.
> 
> There isn't a lot of documentation available for the use of arp_filter.
> 

I put interfaces on the same network too, and it works for me.  I do
use source-based routing (using the 'ip' command) though, which
may be why it works for me...

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
