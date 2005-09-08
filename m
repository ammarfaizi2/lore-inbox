Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVIHXKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVIHXKE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 19:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbVIHXKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 19:10:04 -0400
Received: from ip18.tpack.net ([213.173.228.18]:17117 "HELO mail.tpack.net")
	by vger.kernel.org with SMTP id S965072AbVIHXKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 19:10:01 -0400
Message-ID: <4320C555.4020800@tpack.net>
Date: Fri, 09 Sep 2005 01:12:21 +0200
From: Tommy Christensen <tommy.christensen@tpack.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bogdan.Costescu@iwr.uni-heidelberg.de, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] 3c59x: read current link status from phy
References: <200509080125.j881PcL9015847@hera.kernel.org>	<431F9899.4060602@pobox.com>	<Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de>	<1126184700.4805.32.camel@tsc-6.cph.tpack.net>	<Pine.LNX.4.63.0509081521140.21354@dingo.iwr.uni-heidelberg.de>	<1126190554.4805.68.camel@tsc-6.cph.tpack.net>	<Pine.LNX.4.63.0509081713500.22954@dingo.iwr.uni-heidelberg.de>	<4320BD96.3060307@tpack.net> <20050908154114.69307f92.akpm@osdl.org>
In-Reply-To: <20050908154114.69307f92.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Should we also decrease the polling interval?  Perhaps only when the cable
> is unplugged?

Sounds like a plan. 60 seconds certainly strikes me as being very slow.
OTOH, I'm not aware of the reasoning behind this choice in the first place.
It might make sense for some odd setups.

Since I don't even have any HW to play around with, I think I'll step
down for now.


-Tommy
