Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSKSKol>; Tue, 19 Nov 2002 05:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSKSKol>; Tue, 19 Nov 2002 05:44:41 -0500
Received: from dialup157.canberra.net.au ([203.33.188.29]:2565 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S264954AbSKSKok>;
	Tue, 19 Nov 2002 05:44:40 -0500
Message-ID: <3DDA17D2.4020004@cyberone.com.au>
Date: Tue, 19 Nov 2002 21:52:02 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.48-mm1
References: <3DDA0153.A1971C76@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.48/2.5.48-mm1/
>
snip

>
>
>Since 2.5.47-mm3:
>
snip

>+np-deadline.patch
>
> Deadline scheduler work from Nick Piggin
>
snip

This may degrade IO read latency a little bit and will
still be suboptimal when there are both read and write
requests outstanding for some io patterns (no worse than
47-mm3). Jens and I have been making progress here however.

Nick

