Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312575AbSDXTnW>; Wed, 24 Apr 2002 15:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312581AbSDXTnV>; Wed, 24 Apr 2002 15:43:21 -0400
Received: from ip68-3-16-134.ph.ph.cox.net ([68.3.16.134]:21642 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S312575AbSDXTnV>;
	Wed, 24 Apr 2002 15:43:21 -0400
Message-ID: <3CC70AD6.6070604@candelatech.com>
Date: Wed, 24 Apr 2002 12:43:18 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jd@epcnet.de, linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
In-Reply-To: <3CC6EBF1.9060902@candelatech.com>	<20020424.102528.98393867.davem@redhat.com>	<3CC6F22E.9060402@candelatech.com> <20020424.105602.81442098.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

>    From: Ben Greear <greearb@candelatech.com>
>    Date: Wed, 24 Apr 2002 10:58:06 -0700
>    
>    > But the changes are wrong, just because they work for some people
>    > doesn't make the change mergeable into the main tree.
>    
>    Wrong is a strong word for a change that makes it work for some people without
>    obvious negative side effects.
> 
> Ummm, sed 's/obvious/known/'  We don't know what the patch
> even does.


We may not know EVERYTHING the patch does, but we do know that it
enables VLANs to work, and does not degrade other functionality in
any _observable_ way (to this point in time, at least.)

If someone wants to use VLANS, and wants to use EEPRO nics, then this
patch is obviously better than the unpatched driver.  Thus my suggestion
that we make it easier for users to enable this patch/hack/whatever.

Allowing a #define switch, or even clearly commented driver code that
a FAQ can point to will help the VLAN user, and will not AT ALL affect
non-vlan aware users.

If/when the e100 guys show us a better way, no one will argue that
you shouldn't modify the eepro100 to be more kosher.


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


