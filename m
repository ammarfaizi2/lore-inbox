Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266584AbUBMA62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 19:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266638AbUBMA61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 19:58:27 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:45215 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266584AbUBMA6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 19:58:14 -0500
Message-ID: <402C2105.1030905@cyberone.com.au>
Date: Fri, 13 Feb 2004 11:57:41 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rudo Thomas <rudo@matfyz.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug, or is it? - SCHED_RR and FPU related
References: <20040212205708.GA1679@ss1000.ms.mff.cuni.cz> <402C050B.2040803@cyberone.com.au> <20040213004727.GA20680@ss1000.ms.mff.cuni.cz>
In-Reply-To: <20040213004727.GA20680@ss1000.ms.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rudo Thomas wrote:

>Hi.
>
>
>>xmms probably goes into an infinite loop, preventing anything else
>>from being scheduled, right?
>>
>
>Nope. When I turn the suid bit off, xmms (does not run with SCHED_RR and) just
>hangs consuming no CPU cycles. Strange.
>
>I will look into it tomorrow, the invalid FP division was not the problem, its
>results are.
>
>

I think xmms changes the way it runs depending on whether realtime
scheduling is set or not, but I could be wrong.

Programs using realtime scheduling need to be coded pretty
carefully. Xmms is not something I'd bet my system's stability on.

