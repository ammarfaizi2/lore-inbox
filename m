Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbTBULJH>; Fri, 21 Feb 2003 06:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTBULJH>; Fri, 21 Feb 2003 06:09:07 -0500
Received: from dial-ctb04109.webone.com.au ([210.9.244.109]:22276 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267372AbTBULJG>;
	Fri, 21 Feb 2003 06:09:06 -0500
Message-ID: <3E560AE3.8030309@cyberone.com.au>
Date: Fri, 21 Feb 2003 22:17:55 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
References: <20030220212304.4712fee9.akpm@digeo.com> <Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com> <20030221001624.278ef232.akpm@digeo.com> <20030221103140.GN31480@x30.school.suse.de> <20030221105146.GA10411@holomorphy.com> <20030221110807.GQ31480@x30.school.suse.de>
In-Reply-To: <20030221110807.GQ31480@x30.school.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>it's like a dma ring buffer size of a soundcard, if you want low latency
>it has to be small, it's as simple as that. It's a tradeoff between
>
Although the dma buffer is strictly FIFO, so the situation isn't
quite so simple for disk IO.

