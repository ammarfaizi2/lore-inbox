Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWALGys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWALGys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWALGys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:54:48 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:10636 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751239AbWALGys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:54:48 -0500
Message-ID: <43C5FD35.6080605@bigpond.net.au>
Date: Thu, 12 Jan 2006 17:54:45 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, apw@shadowen.org
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C5B945.3000903@google.com> <43C5F8C8.60908@mbligh.org> <200601121741.36042.kernel@kolivas.org>
In-Reply-To: <200601121741.36042.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 12 Jan 2006 06:54:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Thu, 12 Jan 2006 05:35 pm, Martin J. Bligh wrote:
> 
>>Martin Bligh wrote:
>>
>>>>This is a shot in the dark. We haven't confirmed 1. there is a
>>>>problem 2. that this is the problem nor 3. that this patch will fix
>>>>the problem. I say we wait for the results of 1. If the improved smp
>>>>nice handling patch ends up being responsible then it should not be
>>>>merged upstream, and then this patch can be tested on top.
>>>>
>>>>Martin I know your work move has made it not your responsibility to
>>>>test backing out this change, but are you aware of anything being
>>>>done to test this hypothesis?
>>
>>OK, backing out that patch seems to fix it. Thanks Andy ;-)
> 
> 
> Yes thanks!
> 
> I just noticed the result myself and emailed on another branch of this email 
> thread. Gah

It would nice to get a run with the patch back in and my fix applied.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
