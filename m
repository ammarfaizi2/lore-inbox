Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTDZDAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 23:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264602AbTDZDAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 23:00:09 -0400
Received: from static-ctb-210-9-247-179.webone.com.au ([210.9.247.179]:30472
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264601AbTDZDAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 23:00:08 -0400
Message-ID: <3EA9F8F2.3070303@cyberone.com.au>
Date: Sat, 26 Apr 2003 13:11:46 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: rwhron@earthlink.net, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.68 and 2.5.68-mm2
References: <20030426015856.GA2286@rushmore> <3EA9ECFB.5050407@cyberone.com.au>
In-Reply-To: <3EA9ECFB.5050407@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>
>
> rwhron@earthlink.net wrote:
>
>>> The benchmark is hitting a pathologoical case.  Yeah, it's a 
>>> problem, but
>>> it's not as bad as tiobench indicates.
>>>
> Its interesting that deadline does so much better for this case
> though. I wonder if any other differences in mm could cause it?
> A run with deadline on mm would be nice to see. IIRC my tests
> showed AS doing as well or better than deadline in smp tiobench.
> The bad random read performance is a problem too, because the
> fragmentation should only add to the randomness.
> I'll have to investigate this further.
>
Are you using TCQ by any chance? If so, what do the results look
like with TCQ off?

