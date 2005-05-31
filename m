Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVEaKuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVEaKuC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVEaKuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:50:02 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:9124 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261777AbVEaKt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:49:59 -0400
Message-ID: <429C4152.9050605@yahoo.com.au>
Date: Tue, 31 May 2005 20:49:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Shaohua Li <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Rusty Russell <rusty@rustcorp.com.au>, ashok.raj@intel.com
Subject: Re: [PATCH]CPU hotplug breaks wake_up_new_task
References: <1117524909.3820.11.camel@linux-hp.sh.intel.com> <20050531094045.GA9884@in.ibm.com> <429C3265.4010704@yahoo.com.au> <20050531104055.GA9908@in.ibm.com>
In-Reply-To: <20050531104055.GA9908@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Tue, May 31, 2005 at 07:46:13PM +1000, Nick Piggin wrote:
> 
>>And this patch will break balance-on-fork.
> 
> 
> Right :-)
> 
> 
>>How about conditionally setting task_cpu if the task's current
>>CPU is offline?
> 
> 
> Something like this?
> 

That's exactly what I had in mind ;)
Shaohua, do you agree?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
