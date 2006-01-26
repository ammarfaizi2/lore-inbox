Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWAZF7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWAZF7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 00:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWAZF7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 00:59:22 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:62342 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750807AbWAZF7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 00:59:22 -0500
Message-ID: <43D86531.1080708@cosmosbay.com>
Date: Thu, 26 Jan 2006 06:59:13 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Wei Yongjun <weiyj@soft.fujitsu.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]ip_options_fragment() has no effect on fragmentation
References: <0a3101c6229a$3cc7c1b0$cfa0220a@WeiYJ>
In-Reply-To: <0a3101c6229a$3cc7c1b0$cfa0220a@WeiYJ>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [62.23.185.226]); Thu, 26 Jan 2006 06:59:18 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yongjun a écrit :
> [1]Summary of the problem:
> ip_options_fragment() has no effect on fragmentation
> 
> [2]Full description of the problem:
> When I send IPv4 packet(contain Record Route Option) which need to be 
> fragmented to the router, the router can not fragment it correctly.
> After fragmented by router, the second fragmentation still contain 
> Record Route Option. Refer to RFC791, Record Route Option must Not be 
> copied on fragmentation, goes in first fragment only.
> ip_options_fragment() is the implemental function, but there are some 
> BUGs in it:
> 

Hello Wei

This is the third time I receive this patch (and I am not able to comment it), 
and still you didnt send it to the right list.

Please use netdev@vger.kernel.org for any linux kernel networking stuff.

If you dont receive an acknowledge from this netdev list, please wait at least 
two weeks before resending it.

Thank you
Eric

