Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUHXNtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUHXNtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267838AbUHXNtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:49:09 -0400
Received: from mail3.utc.com ([192.249.46.192]:33954 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S267799AbUHXNtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:49:06 -0400
Message-ID: <412B4736.4040706@cybsft.com>
Date: Tue, 24 Aug 2004 08:48:38 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>	 <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu>	 <20040823210151.GA10949@elte.hu> <1093312154.862.17.camel@krustophenia.net>	 <20040824054128.GA29027@elte.hu> <1093326406.817.7.camel@krustophenia.net>
In-Reply-To: <1093326406.817.7.camel@krustophenia.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2004-08-24 at 01:41, Ingo Molnar wrote:
> 
>>* Lee Revell <rlrevell@joe-job.com> wrote:
>>
>>
>>>> - reduce netdev_max_backlog to 8 (Mark H Johnson)
>>>
>>>On my system this setting has absolutely no effect on the skb related
>>>latencies. [...]
>>
>>it has an effect on input queue length. Output queue lengths can be
>>reduced via 'ifconfig eth0 txqueuelen 8'.
>>
> 
> 
> OK.  With both of these set to 4, the largest latency I was able to
> generate by ping flooding was 253 usecs.
> 

Even with both of these set to 4, I still get similar results ~647 usec :(

<snip>
