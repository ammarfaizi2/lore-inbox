Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbRESRp4>; Sat, 19 May 2001 13:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261916AbRESRpr>; Sat, 19 May 2001 13:45:47 -0400
Received: from geos.coastside.net ([207.213.212.4]:47021 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261914AbRESRpk>; Sat, 19 May 2001 13:45:40 -0400
Mime-Version: 1.0
Message-Id: <p0510031fb72c5fb3def3@[207.213.214.37]>
In-Reply-To: <81BywVLHw-B@khms.westfalen.de>
In-Reply-To: <811opRpHw-B@khms.westfalen.de>
 <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
 <p05100316b7272cdfd50c@[207.213.214.37]> <811opRpHw-B@khms.westfalen.de>
 <p05100301b72a335d4b61@[10.128.7.49]> <81BywVLHw-B@khms.westfalen.de>
Date: Sat, 19 May 2001 10:45:06 -0700
To: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:42 AM +0200 2001-05-19, Kai Henningsen wrote:
>  > >Make your config script look at the hardware MAC addresses. Those don't
>>  >change.
>>
>>  They're not necessarily unique, though.
>
>So if you plug both into the same network segment, that segment is broken? 
>That looks like very stupid design to me.
>
>It's not as if getting enough unique MAC addresses was particularly 
>expensive. These days, even el-cheapo PC network cards get that right. 
>(And have for quite a number of years.)

Many do, some don't. Moreover, the MAC address is volatile in that it 
can be changed at will (via, eg, ifconfig).

I assume that the reason that Sun (for example) defaults to all MAC 
addresses on a system being the same is that it doesn't make sense, 
ordinarily, to plug two Ethernet interfaces into the same network 
segment. If, for some reason, you really want to do that, there's 
ifconfig ready to reassign the MAC address.

If I plug both into the same network segments by accident (because I 
can't tell which is which, say), then my configuration is nearly as 
broken with different MAC addresses as with identical ones; the fix 
is to replug correctly, not to change MAC addresses.
-- 
/Jonathan Lundell.
