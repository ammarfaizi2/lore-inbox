Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWHNRqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWHNRqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWHNRqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:46:20 -0400
Received: from palrel12.hp.com ([156.153.255.237]:6854 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S932333AbWHNRqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:46:19 -0400
Message-ID: <44E0B6E9.8050608@hp.com>
Date: Mon, 14 Aug 2006 10:46:17 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.7.13) Gecko/20060601
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
References: <20060814110359.GA27704@2ka.mipt.ru>
In-Reply-To: <20060814110359.GA27704@2ka.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Benchmarks with trivial epoll based web server showed noticeble (more
> than 40%) imrovements of the request rates (1600-1800 requests per
> second vs. more than 2300 ones). It can be described by more
> cache-friendly freeing algorithm, by tighter objects packing and thus
> reduced cache line ping-pongs, reduced lookups into higher-layer caches
> and so on.

Is that an hypothesis, or did you get a chance to gather cache stats 
with something like http://www.hp.com/go/Caliper or the like on the 
platform(s) you were testing?

rick jones

