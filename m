Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVDFITK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVDFITK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVDFITK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:19:10 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:40376 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262068AbVDFIQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:16:48 -0400
Message-ID: <42539AEC.6000204@yahoo.com.au>
Date: Wed, 06 Apr 2005 18:16:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 5/5] sched: consolidate sbe sbf
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au> <42532427.3030100@yahoo.com.au> <20050406062723.GC5973@elte.hu> <4253993C.4020505@yahoo.com.au>
In-Reply-To: <4253993C.4020505@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> 
> One problem I just noticed, sorry. This is doing set_cpus_allowed
> without holding the runqueue lock and without checking the hard
> affinity mask either.
> 

Err, that is to say set_task_cpu, not set_cpus_allowed.

-- 
SUSE Labs, Novell Inc.

