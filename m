Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbVIIABq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVIIABq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 20:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbVIIABq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 20:01:46 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29066 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965086AbVIIABp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 20:01:45 -0400
Message-ID: <4320D0DB.3040405@pobox.com>
Date: Thu, 08 Sep 2005 20:01:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tommy Christensen <tommy.christensen@tpack.net>
CC: Andrew Morton <akpm@osdl.org>, Bogdan.Costescu@iwr.uni-heidelberg.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] 3c59x: read current link status from phy
References: <200509080125.j881PcL9015847@hera.kernel.org>	<431F9899.4060602@pobox.com>	<Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de>	<1126184700.4805.32.camel@tsc-6.cph.tpack.net>	<Pine.LNX.4.63.0509081521140.21354@dingo.iwr.uni-heidelberg.de>	<1126190554.4805.68.camel@tsc-6.cph.tpack.net>	<Pine.LNX.4.63.0509081713500.22954@dingo.iwr.uni-heidelberg.de>	<4320BD96.3060307@tpack.net> <20050908154114.69307f92.akpm@osdl.org> <4320C555.4020800@tpack.net>
In-Reply-To: <4320C555.4020800@tpack.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommy Christensen wrote:
> Andrew Morton wrote:
> 
>> Should we also decrease the polling interval?  Perhaps only when the 
>> cable
>> is unplugged?
> 
> 
> Sounds like a plan. 60 seconds certainly strikes me as being very slow.
> OTOH, I'm not aware of the reasoning behind this choice in the first place.
> It might make sense for some odd setups.
> 
> Since I don't even have any HW to play around with, I think I'll step
> down for now.

The standard for Becker drivers is 5 seconds if link is down, and 60 
seconds if link is up, IIRC.

	Jeff



