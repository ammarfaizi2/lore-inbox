Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVHCMFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVHCMFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVHCMDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:03:32 -0400
Received: from mail.isurf.ca ([66.154.97.68]:34194 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S262248AbVHCMBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:01:18 -0400
Message-ID: <42F0B223.20404@staticwave.ca>
Date: Wed, 03 Aug 2005 08:01:39 -0400
From: Gabriel Devenyi <ace@staticwave.ca>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ck] [ANNOUNCE] Interbench v0.26
References: <200508031758.31246.kernel@kolivas.org>
In-Reply-To: <200508031758.31246.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You haven't quite completely fixed the SD calculations it seems:


--- Benchmarking simulated cpu of Gaming in the presence of simulated---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None       2.44 +/- nan         48.6            98.7
Video      12.8 +/- nan         55.2              89
X          89.7 +/- nan          494            52.8
Burn        400 +/- nan         1004            20.1
Write      49.2 +/- nan          343            67.2
Read       4.14 +/- nan         56.7            96.7
Compile     551 +/- nan         1369            15.4


--
Gabriel Devenyi
ace@staticwave.ca

Con Kolivas wrote:
> This benchmark application is designed to benchmark interactivity in Linux.
> 
> Direct download link:
> http://ck.kolivas.org/apps/interbench/interbench-0.26.tar.bz2
> 
> Web site:
> http://interbench.kolivas.org
> 
> Changes since v0.24:
> 
> v0.25:
> The timekeeping thread of background load no longer runs SCHED_FIFO. The 
> benchmark is allowed to proceed if it does not detect swap and instead 
> disables mem_load. The documentation was updated.
> 
> v0.26:
> Fixed the standard deviation measurements at last (thanks Peter Williams). 
> There should be no practical limit to how long you can run a benchmark for 
> now.
> 
> Cheers,
> Con
> _______________________________________________
> ck@vds.kolivas.org
> ck mailing list. Please reply-to-all when posting.
> If replying to an email please reply below the original message.
> http://bhhdoa.org.au/mailman/listinfo/ck
> 
