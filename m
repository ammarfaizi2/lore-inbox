Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268209AbUHXAwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268209AbUHXAwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267792AbUHXAu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:50:26 -0400
Received: from mail-12.iinet.net.au ([203.59.3.44]:52189 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S268180AbUHXAlX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 20:41:23 -0400
Message-ID: <412A8EAD.3060907@cyberone.com.au>
Date: Tue, 24 Aug 2004 10:41:17 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance of -mm2 and -mm4
References: <336080000.1093280286@[10.10.2.4]> <200408231431.25986.jbarnes@engr.sgi.com>
In-Reply-To: <200408231431.25986.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jesse Barnes wrote:

>On Monday, August 23, 2004 9:58 am, Martin J. Bligh wrote:
>
>>The -mm4 looks more like sched stuff to me (copy_to/from_user, etc),
>>but the -mm2 stuff looks like something else. Buggered if I know what.
>>-mm3 didn't compile cleanly, so I didn't bother, but I prob can if you
>>like.
>>
>
>If you suspect the scheduler, you could try bumping SD_NODES_PER_DOMAIN in 
>kernel/sched.c to a larger value (e.g. the number of nodes in your system).  
>That'll make the scheduler balance more aggressively across the whole system.
>
>

Try increasing /proc/sys/kernel/base_timeslice as well.

