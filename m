Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVF1CbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVF1CbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 22:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVF1CbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 22:31:06 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:64210 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S262273AbVF1Ca4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 22:30:56 -0400
Message-ID: <42C0B65D.40507@bigpond.net.au>
Date: Tue, 28 Jun 2005 12:30:53 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] sched: consider migration thread with smp nice
References: <200506261825.19740.kernel@kolivas.org> <42C09D31.5030207@bigpond.net.au> <200506281048.29674.kernel@kolivas.org>
In-Reply-To: <200506281048.29674.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 28 Jun 2005 02:30:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tue, 28 Jun 2005 10:43, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>>
>>>This patch improves throughput with the smp nice balancing code. Many
>>>thanks to Martin Bligh for the usage of his regression testing bed to
>>>confirm the effectiveness of various patches.
>>
>>Con,
>>	This doesn't build on non SMP systems due to the migration_thread field
>>only being defined for SMP.  Attached is a copy of a slightly modified
>>PlugSched version of the patch which I used to fix the problem in
>>PlugSched.  Even though it's for a different file it should be easy to
>>copy over.
> 
> 
> Peter
> 
> Look at the actual patch I sent out you'll see it moved the ifdefs up to 
> compensate. I believe your port of my patch doesn't build and I suspect it's 
> because you missed these ifdef movements ;)

Yes, I should have read the patch more carefully.

Sorry about that,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
