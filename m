Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTIMLR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 07:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTIMLR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 07:17:29 -0400
Received: from dyn-ctb-210-9-245-223.webone.com.au ([210.9.245.223]:52999 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262126AbTIMLRU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 07:17:20 -0400
Message-ID: <3F62FCBB.2020807@cyberone.com.au>
Date: Sat, 13 Sep 2003 21:17:15 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Nick's scheduler policy v15
References: <200309121839.h8CIdao22695@mail.osdl.org> <3F627BAC.5040706@cyberone.com.au>
In-Reply-To: <3F627BAC.5040706@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Cliff White wrote:
>
>>> Hi,
>>> http://www.kerneltrap.org/~npiggin/v15/
>>>
>>>
>>
>> Here are results for several recent kernels for comparison.
>> the sched-rollup-nopolicy tests are still running. Performance of v15 
>> suffers as number of CPU's increase.
>> At 8 cpu's, delta is noticeable vs stock -test5
>> cliffw
>>
>
> OK, so it hasn't crashed? Do you have the profiles up?


Nevermind, I found them. It looks like its balancing way too much. I've
a few ideas. I should be getting time on a NUMA box there at OSDL soon, 
so I won't bother you with untested stuff. Thanks again for doing
these.


