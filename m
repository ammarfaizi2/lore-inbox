Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbUC3Q1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUC3Q1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:27:17 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:22915 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263734AbUC3Q1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:27:16 -0500
Message-ID: <40699F66.4060001@pacbell.net>
Date: Tue, 30 Mar 2004 08:25:10 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Robert Schwebel <robert@schwebel.de>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
References: <20040325221145.GJ10711@pengutronix.de> <20040326115947.GA22185@outpost.ds9a.nl> <20040326121928.GC16461@pengutronix.de> <4064530C.5030308@pacbell.net> <20040326163543.GD16461@pengutronix.de> <40646C2B.6020306@pacbell.net> <20040326184142.GF16461@pengutronix.de>
In-Reply-To: <20040326184142.GF16461@pengutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
>>Most of the patch is the (R)NDIS support code, which is easy
>>to merge, but the "g_ether" updates will take longer.
> 
> 
> Ok. We have tried to make the design as minimal-invasive as possible... 

And that pretty much worked ... I've sent Greg a 2.6
version, tested with net2280 and goku_udc, so I hope
that'll appear in some "-mm" patch soonish (and then
presumably in 2.6.6-early).

It does need testing on PXA though.

- Dave




