Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262554AbTDBHqK>; Wed, 2 Apr 2003 02:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbTDBHqK>; Wed, 2 Apr 2003 02:46:10 -0500
Received: from dial-ctb05128.webone.com.au ([210.9.245.128]:46090 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S262554AbTDBHqI>;
	Wed, 2 Apr 2003 02:46:08 -0500
Message-ID: <3E8A97D6.3000603@cyberone.com.au>
Date: Wed, 02 Apr 2003 17:57:10 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.66-mm2 with contest
References: <200304021324.10799.kernel@kolivas.org> <3E8A6227.7080209@cyberone.com.au> <20030402074227.GH901@suse.de>
In-Reply-To: <20030402074227.GH901@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Wed, Apr 02 2003, Nick Piggin wrote:
>
>>Con Kolivas wrote:
>>
>>
>>>Big rise in ctar_load and io_load. Drop in read_load.
>>>(All uniprocessor with IDE and AS elevator). AS tweaks? No obvious 
>>>scheduler tweak result changes.
>>>
>>>
>>Thanks Con,
>>I'm a bit busy now, but next week I'll work something out for it.
>>It is most likely to be as-queue_notready-cleanup.patch. I'll
>>wait until after Jens ports his dynamic requests stuff over to
>>mm before I go further.
>>
>
>It is ported, I sent Andrew the patch yesterday. I'm attaching it here
>as well.
>
Thanks for doing that, Jens. Any CPU measurements on the hash
goodness that you did for deadline?

