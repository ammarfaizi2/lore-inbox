Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTH1LJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 07:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263907AbTH1LJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 07:09:04 -0400
Received: from dyn-ctb-210-9-243-35.webone.com.au ([210.9.243.35]:62727 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263898AbTH1LI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 07:08:59 -0400
Message-ID: <3F4DE2C2.20307@cyberone.com.au>
Date: Thu, 28 Aug 2003 21:08:50 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v8
References: <3F4DC208.8050606@cyberone.com.au> <1062068387.1200.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1062068387.1200.1.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felipe Alfaro Solana wrote:

>On Thu, 2003-08-28 at 10:49, Nick Piggin wrote:
>
>
>>No big changes, this one takes some of the steepness out of the
>>timeslice curve and fixes a bug with child priorities which
>>might or might not help startup times. Probably no point doing
>>any benchmarks on it if they've been done on v7.
>>
>
>I've been playing with it for a while and, from what I've seen until
>date, I must say it makes X feel smooth (even when X not reniced,
>although I've reniced it to -20). However, it still feels a little bit
>slower when forking new processes under heavy load. I'll do some
>benchmarking and will post numbers here.
>Thanks!
>

Hi Felipe,
Sorry I can't reply directly to you. Something thinks I'm spam...
Anyway, thanks for all your good feedback. The slower fork response
is something I haven't been able to get quite right without causing
kernel compiles to slow things down _too_ much. I have a few more
ideas though.



