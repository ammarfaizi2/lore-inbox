Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbTAJSYS>; Fri, 10 Jan 2003 13:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbTAJSYS>; Fri, 10 Jan 2003 13:24:18 -0500
Received: from [193.158.237.250] ([193.158.237.250]:38279 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265568AbTAJSYR>; Fri, 10 Jan 2003 13:24:17 -0500
Date: Fri, 10 Jan 2003 19:32:57 +0100
Message-Id: <200301101832.h0AIWvh02736@mail.intergenia.de>
To: <3E1E50FB.4000301@emageon.com>
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440) [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Or perhaps the kernel version is not up-to-date. Please also provide
>> the precise kernel version (and included patches). And workload too.

On Thu, Jan 09, 2003 at 10:50:03PM -0600, Brian Tinsley wrote:
> The kernel version is stock 2.4.20 with Chris Mason's data logging and 
> journal relocation patches for ReiserFS (neither of which are actually 
> in use for any mounted filesystems). It is compiled for 64GB highmem 
> support. And just to refresh, I have seen this exact behavior on stock 
> 2.4.19 and stock 2.4.17 (no patches on either of these) also compiled 
> with 64GB highmem support.

Okay, can you try with either 2.4.x-aa or 2.5.x-CURRENT?

I'm suspecting either bh problems or lowpte problems.

Also, could you monitor your load with the scripts I posted?


Thanks,
Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

