Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWB1CPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWB1CPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 21:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWB1CPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 21:15:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750712AbWB1CPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 21:15:35 -0500
Date: Mon, 27 Feb 2006 18:14:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Tejun Heo <htejun@gmail.com>, Mark Lord <lkml@rtr.ca>,
       David Greaves <david@dgreaves.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <4403B04F.5090405@pobox.com>
Message-ID: <Pine.LNX.4.64.0602271813120.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
 <Pine.LNX.4.64.0602271744470.22647@g5.osdl.org> <4403B04F.5090405@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Feb 2006, Jeff Garzik wrote:
> 
> I've had this waiting in the wings, in fact...  [see attached]

I really hate having a _global_ variable called "fua". That's just bad 
taste. I would suggest calling it "atapi_forced_unit_attention_enabled", 
but maybe that is going a bit overboard. It's definitely better than just 
"fua", though.

			Linus
