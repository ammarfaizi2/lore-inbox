Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVDMBF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVDMBF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVDMBDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:03:05 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:62393 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262141AbVDMBCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:02:33 -0400
Message-ID: <425C6F98.7060705@yahoo.com.au>
Date: Wed, 13 Apr 2005 11:02:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: axboe@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [patch 1/9] GFP_ZERO fix
References: <425BC262.1070500@yahoo.com.au>	<425BC387.3080703@yahoo.com.au> <20050412124741.366caee3.akpm@osdl.org>
In-Reply-To: <20050412124741.366caee3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>  #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
>> -			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
>> -			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
>> +			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|__GFP_NOFAIL| \
>> +			__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP|__GFP_ZERO)
> 
> 
> Passing GFP_ZERO into kmem_cache_alloc() is such a bizarre thing to do,
> perhaps a BUG is the correct response.
> 

I just thought it was a bit cheeky given the comment right above it ;)


-- 
SUSE Labs, Novell Inc.

