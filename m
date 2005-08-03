Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVHCX0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVHCX0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVHCX0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:26:10 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:629 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261624AbVHCXZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:25:26 -0400
Message-ID: <42F15264.20409@bigpond.net.au>
Date: Thu, 04 Aug 2005 09:25:24 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Gabriel Devenyi <ace@staticwave.ca>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org, Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ck] [ANNOUNCE] Interbench v0.26
References: <200508031758.31246.kernel@kolivas.org> <42F0B223.20404@staticwave.ca> <200508032203.44795.kernel@kolivas.org>
In-Reply-To: <200508032203.44795.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 3 Aug 2005 23:25:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 3 Aug 2005 22:01, Gabriel Devenyi wrote:
> 
>>You haven't quite completely fixed the SD calculations it seems:
>>
>>
>>--- Benchmarking simulated cpu of Gaming in the presence of simulated---
>>Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
>>None       2.44 +/- nan         48.6            98.7
>>Video      12.8 +/- nan         55.2              89
>>X          89.7 +/- nan          494            52.8
>>Burn        400 +/- nan         1004            20.1
>>Write      49.2 +/- nan          343            67.2
>>Read       4.14 +/- nan         56.7            96.7
>>Compile     551 +/- nan         1369            15.4
> 
> 
>>:(
> 
> 
> I keep trying

The problem is a variation of the original one that I pointed out.  The 
value that's being added to the sum of the squares of the latency is not 
always the square of the value being added to the latency.

Would you like me to fix it and send you a patch?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
