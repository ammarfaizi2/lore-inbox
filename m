Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUBVEcq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 23:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUBVEcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 23:32:46 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:34744 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261677AbUBVEco
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 23:32:44 -0500
Message-ID: <4038307B.2090405@cyberone.com.au>
Date: Sun, 22 Feb 2004 15:30:51 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@osdl.org>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au> <40382BAA.1000802@cyberone.com.au>
In-Reply-To: <40382BAA.1000802@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
> Actually I think the previous shrink_slab formula factors
> out to the right thing anyway, so nevermind this patch :P
>
>

Although, nr_used_zone_pages probably shouldn't be counting
highmem zones, which might be our problem.


