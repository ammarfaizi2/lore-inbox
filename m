Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264140AbRFMBxc>; Tue, 12 Jun 2001 21:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264143AbRFMBxW>; Tue, 12 Jun 2001 21:53:22 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:58326 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264140AbRFMBxK>;
	Tue, 12 Jun 2001 21:53:10 -0400
Message-ID: <3B26C779.ECE9017C@candelatech.com>
Date: Tue, 12 Jun 2001 18:52:57 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Ken Brownfield <brownfld@irridia.com>, Florin Andrei <florin@sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.19: eepro100 and cmd_wait issues
In-Reply-To: <Pine.LNX.4.33.0106121702500.25366-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> 
> I am useing the D-link 4 port card without running into problems
> (admittidly I have not been stressing it much yet)

I was able to get the D-Link to work in half-duplex (100bt), but
not in auto-negotiate or full-duplex mode.  (Packets would pass,
but there would be huge number of carrier and other bad packets.)

I get a similar problem with the ZNYX 4-port, but I can't even
force it to half-duplex, or any other fixed speed (it just won't go).
It kinda autonegotiates something, claiming to be full-duplex, but it
still shows collisions and I can't get through-put above about 10Mbps
bi-directional, and its dropping many packets.

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
