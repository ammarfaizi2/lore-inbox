Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTFCARQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 20:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTFCARQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 20:17:16 -0400
Received: from dyn-ctb-210-9-244-45.webone.com.au ([210.9.244.45]:6917 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264252AbTFCARP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 20:17:15 -0400
Message-ID: <3EDBEC27.9070705@cyberone.com.au>
Date: Tue, 03 Jun 2003 10:30:31 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.70-mm2 with contest
References: <200306030806.49885.kernel@kolivas.org> <20030602151644.06252b28.akpm@digeo.com>
In-Reply-To: <20030602151644.06252b28.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Con Kolivas <kernel@kolivas.org> wrote:
>
>>io_load:
>>Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
>>2.5.69              4   343     22.7    120.5   19.8    4.29
>>2.5.69-mm3          4   319     24.5    105.3   18.1    4.04
>>2.5.69-mm5          4   137     56.9    49.6    19.0    1.73
>>2.5.69-mm6          4   150     52.0    53.4    18.7    1.92
>>2.5.70              5   326     21.5    112.9   18.7    4.13
>>2.5.70-mm2          4   115     67.0    42.0    19.1    1.47
>>large drop in time with one large file write
>>
>
>We're hitting nearly 90% CPU here.  That is really excellent.
>
Yes, the contest results have held up nicely after those big
changes to AS which is good.

It will be interesting to see what happens if we set the
ext3 journal write paths as PF_SYNCWRITE. I'll try some tests
a bit later today.

