Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUH0W2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUH0W2d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUH0W1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 18:27:41 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:6366 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261610AbUH0WTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 18:19:12 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.9-rc1-mm1
Date: Sat, 28 Aug 2004 00:29:29 +0200
User-Agent: KMail/1.5
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200408272154.i7RLsJk02714@owlet.beaverton.ibm.com>
In-Reply-To: <200408272154.i7RLsJk02714@owlet.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408280029.29339.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 of August 2004 23:54, Rick Lindsley wrote:
>     > Rafael, what baseline release are you comparing to?  I should be able
>     > to provide some tools to measure the effect on updatedb directly for
>     > both 2.6.9-rc1 and your baseline (so long as it's 2.6-based)
>
>     2.6.8.1, for example.  I'd like to compate it with the 2.6.9-rc1-mm1,
> which contains the Nick's scheduler (2.6.9-rc1 has the same scheduler as
> 2.6.8.1, AFAIK).
>
> Okay.  A schedstats patch for 2.6.8.1 is available at
>
>     http://eaglet.rain.com/rick/linux/schedstat/patches/schedstat-2.6.8.1
>     or
>     http://oss.software.ibm.com/linux/patches/?patch_id=730
>
> You can also pick up the program "latency.c" at
>
>     http://eaglet.rain.com/rick/linux/schedstat/v9/latency.c
>
> With these two things in hand, you should be able to measure the latency
> on 2.6.8.1 of a particular process.
>
> A patch is not necessary for 2.6.9-rc1-mm1 (schedstats is already in there)
> but you will need to config the kernel to use it.  Then retrieve a slightly
> different latency.c:
>
>     http://eaglet.rain.com/rick/linux/schedstat/v10/latency.c
>
> since 2.6.9-rc1-mm1 output format is different (as you noted, it's a
> different scheduler.)  Then you should be able to see if the latency of
> a particular process (updatedb, for instance) changes.

Thanks a lot Rick, I'll give it a try tomorrow.

Regards,
RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
