Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbUBVEll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 23:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUBVEll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 23:41:41 -0500
Received: from adsl-63-194-240-129.dsl.lsan03.pacbell.net ([63.194.240.129]:51205
	"EHLO mikef-fw.mikef-fw.matchmail.com") by vger.kernel.org with ESMTP
	id S261676AbUBVElj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 23:41:39 -0500
Message-ID: <40383300.5010203@matchmail.com>
Date: Sat, 21 Feb 2004 20:41:36 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au> <40382BAA.1000802@cyberone.com.au> <4038307B.2090405@cyberone.com.au>
In-Reply-To: <4038307B.2090405@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> 
> 
> Nick Piggin wrote:
> 
>>
>> Actually I think the previous shrink_slab formula factors
>> out to the right thing anyway, so nevermind this patch :P
>>
>>
> 
> Although, nr_used_zone_pages probably shouldn't be counting
> highmem zones, which might be our problem.

What is the kernel parameter to disable highmem?  I saw nohighio, but 
that's not it...

Doesn't "mem=" have alignment problems?

