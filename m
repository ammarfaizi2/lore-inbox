Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270267AbRHHCQp>; Tue, 7 Aug 2001 22:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270269AbRHHCQf>; Tue, 7 Aug 2001 22:16:35 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:3812 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S270267AbRHHCQ0>;
	Tue, 7 Aug 2001 22:16:26 -0400
Message-ID: <3B70A0DA.DE33CB87@candelatech.com>
Date: Tue, 07 Aug 2001 19:15:54 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stuart Duncan <sety@perth.wni.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ARP's frustrating behavior
In-Reply-To: <5.1.0.14.0.20010808094513.00ab72c8@mailhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Duncan wrote:
> 
> Hi,
> 
> I'm noticing on a machine with dual NICs that they they all seem to answer
> ARP queries, even if the request is not directed to their IP.  Here's an
> example:
> 

Evidently, this is considered a feature.  However, to turn it off:
echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
