Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUGWE3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUGWE3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 00:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267537AbUGWE3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 00:29:13 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:56433 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261451AbUGWE3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 00:29:09 -0400
Message-ID: <41009411.1080401@yahoo.com.au>
Date: Fri, 23 Jul 2004 14:29:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Dimitri Sivanich <sivanich@sgi.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch for isolated scheduler domains
References: <20040722164126.GB13189@sgi.com> <20040722175459.GA30059@elte.hu> <4100859C.9060409@yahoo.com.au> <20040723041349.GB15188@sgi.com>
In-Reply-To: <20040723041349.GB15188@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich wrote:
> On Fri, Jul 23, 2004 at 01:27:24PM +1000, Nick Piggin wrote:
> 
>>Cool. Have you actually tried running it? With Ingo's correction, it
>>should work fine but I don't think anyone has tested this.
>>
> 
> Yup, I've been running it on an Altix.
> 

Great.

> I've created a version for sched.c (all platform) which I'll be posting
> soon.  That will include code for both CONFIG_NUMA_SCHED and non
> CONFIG_NUMA_SCHED configurations.

Sorry to throw a spanner in the works, but could you have a look
at the "[PATCH] consolidate sched domains" I just sent in, and
see if you can work on top of that.

I really should have done that patch earlier :\
