Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313078AbSDOIDA>; Mon, 15 Apr 2002 04:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313075AbSDOIC7>; Mon, 15 Apr 2002 04:02:59 -0400
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:25286 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S313070AbSDOIC5>;
	Mon, 15 Apr 2002 04:02:57 -0400
Message-ID: <3CBA892F.2000808@tmsusa.com>
Date: Mon, 15 Apr 2002 01:02:55 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 final - another data point
In-Reply-To: <3CB9EF57.6010609@tmsusa.com> <3CBA6943.4000701@tmsusa.com> <3CBA74A6.3080407@tmsusa.com> <3CBA80C7.467FA654@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>J Sloan wrote:
>
>>
>>Apr 14 20:40:35 neo kernel: invalidate: busy buffer
>>
>
>If that is happening during the dbench run, then something
>is wrong.
>
I am reasonably sure that's when it was happening.

>
>
>What filesystem and I/O drivers are you using?  LVM?
>RAID?
>
Actually just plain old ext2 on ide drives -

>
>Please replace that line in fs:buffer.c:invalidate_bdev()
>with a BUG(), or show_stack(0), send the ksymoops output.
>
OK, will do -

Joe



