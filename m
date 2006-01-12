Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWALKp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWALKp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 05:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWALKpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 05:45:55 -0500
Received: from tornado.reub.net ([202.89.145.182]:46471 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030353AbWALKpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 05:45:55 -0500
Message-ID: <43C63361.103@reub.net>
Date: Thu, 12 Jan 2006 23:45:53 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060111)
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: why sk98lin driver is not up-to date ?
References: <Xns97496767C8536ericbelhommefreefr@80.91.229.5> <200601120339.17071.chase.venters@clientec.com>
In-Reply-To: <200601120339.17071.chase.venters@clientec.com>
Content-Type: text/plain; charset=ISO-8859-6; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2006 10:39 p.m., Chase Venters wrote:
> On Thursday 12 January 2006 03:09, Eric Belhomme wrote:
>> So this archive is more recent than sources included in stock kernel, but
>> older than 2.6.14 kernel, so I wonder why this revision of sk98lin is not
>> included in kernel ?
> 
> Eric,
> 	IIRC, the SysKonnect official GPL driver attempts to support two different 
> chipsets / possibly has other coding issues as well. I think this is the 
> reason SysKonnect's driver is still out of tree. I think some netdev folks 
> might be working on newer drivers, but I haven't been keeping track honestly.

Yes, look at the skge driver in 2.6.15 and the upcoming sky2 in 2.6.16.

I think you'll find those drivers much better than sk98lin and support most if 
not all of the cards that the sk98lin driver works with.  Certainly those two 
replacement drivers are better maintained.

My understanding is that is that sk98lin is in the process of being deprecated.

reuben


