Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbSJEFmA>; Sat, 5 Oct 2002 01:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbSJEFmA>; Sat, 5 Oct 2002 01:42:00 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:35728 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262061AbSJEFl7>;
	Sat, 5 Oct 2002 01:41:59 -0400
Message-ID: <3D9E7CEE.3070507@candelatech.com>
Date: Fri, 04 Oct 2002 22:47:26 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tg3 and Netgear GA302T x 2 locks machine
References: <3D9D16D9.7040008@candelatech.com> <20021004.142428.101875902.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Ben Greear <greearb@candelatech.com>
>    Date: Thu, 03 Oct 2002 21:19:37 -0700
> 
>    Got my two new Netgear GA302t nics today.  They seem to use the
>    tg3 driver....
>    
>    I put them into the 64/66 slots on my Tyan dual amd motherboard..
>    Running kernel 2.4.20-pre8
>    
> You reported the other week problems with two Acenic's in
> this same machine right?  The second Acenic wouldn't even probe
> properly.  And the two Acenic's were identical.
> 
> I see a pattern developing... :-)
> 

Yep, one of my 64-bit PCI slots only seems to work with Intel NICs.
Go figure.

At any rate, I have 4 32-bit slots, and they seem to work, at
least long enough for the driver to puke messages and hard-lock my
machine ;)

If you think this NIC should work with the tg3, then I can change
them to a completely other machine, btw.

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


