Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTIDAyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTIDAyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:54:39 -0400
Received: from dyn-ctb-210-9-244-61.webone.com.au ([210.9.244.61]:10500 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264471AbTIDAyi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:54:38 -0400
Message-ID: <3F568D42.1070004@cyberone.com.au>
Date: Thu, 04 Sep 2003 10:54:26 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: UP Regression (was) Re: Scaling noise
References: <200309031551.h83Fpu413835@mail.osdl.org>
In-Reply-To: <200309031551.h83Fpu413835@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Cliff White wrote:

>[snip]
>.
>
>>I don't think anyone advocates sacrificing UP performance for 32 ways, but
>>as he says it can happen .1% at a time.
>>
>>But it looks like 2.6 will scale well to 16 way and higher. I wonder if
>>there are many regressions from 2.4 or 2.2 on small systems.
>>
>>
>>
>On the Scalable Test Platform, running osdl-aim-7,  for the
>UP case, 2.4 is a bit better than 2.6, this is consistent across
>many runs. For SMP, 2.6 is better, but the delta is rather
>small, until we get to 8 CPUS. We have a lot of un-parsed data from other
>tests - might be some trends there also.
>See http://developer.osdl.org/cliffw/reaim/index.html 
>2.4 kernels are at the bottom of the page.
>

Forgive my ignorance of your benchmarks, but this might very well
be HZ == 1000?


