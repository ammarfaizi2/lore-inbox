Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTJWCVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 22:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTJWCVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 22:21:38 -0400
Received: from mail-09.iinet.net.au ([203.59.3.41]:13440 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261464AbTJWCVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 22:21:37 -0400
Message-ID: <3F973B3F.4000501@cyberone.com.au>
Date: Thu, 23 Oct 2003 12:21:51 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: green@linuxhacker.ru, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Badness in as_completed_request at drivers/block/as-iosched.c:919
References: <20031022123209.GA2652@linuxhacker.ru>	<3F967D66.9090601@cyberone.com.au> <20031022132755.7bfae6a0.akpm@osdl.org>
In-Reply-To: <20031022132755.7bfae6a0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>
>>
>>Oleg Drokin wrote:
>>
>>
>>>Hello!
>>>
>>>
>>>
>>Hi Oleg,
>>The warning should be harmless. I'll remove it once I make sure. I
>>don't think there have been any recent as-iosched changes, so something
>>else must have just triggered it off.
>>
>
>The smartd failure doesn't look harmless:
>
>Device: /dev/sdb, SMART Failure: DATA CHANNEL IMPENDING FAILURE DATA ERROR RATE TOO HIGH
>
>Or does this always happen?
>

I didn't see that. Try booting with elevator=deadline I guess.



