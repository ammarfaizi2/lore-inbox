Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVDFHvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVDFHvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVDFHvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:51:54 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:23911 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262137AbVDFHvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:51:09 -0400
Message-ID: <425394EA.4040003@yahoo.com.au>
Date: Wed, 06 Apr 2005 17:51:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 2/5] sched: NULL domains
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <20050406054518.GB5853@elte.hu> <20050406054818.GA5977@elte.hu>
In-Reply-To: <20050406054818.GA5977@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>* Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>
>>>2/5
>>
>>>The previous patch fixed the last 2 places that directly access a
>>>runqueue's sched-domain and assume it cannot be NULL.
>>>
>>>We can now use a NULL domain instead of a dummy domain to signify
>>>no balancing is to happen. No functional changes.
>>>
>>>Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
>>
>>Acked-by: Ingo Molnar <mingo@elte.hu>
   ^^^

Thanks.

> 
> 
> if the previous 'remove degenerate domains' patch would go away then 
> this patch needs to be merged/modified. (and most of the others as well)
> 

I probably should respin this so it goes in *first* anyway.
Rather than doing half in the remove degenerate domains and
half here.

-- 
SUSE Labs, Novell Inc.

