Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263688AbUD0Coe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbUD0Coe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 22:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUD0Coe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 22:44:34 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:10163 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263688AbUD0Cod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 22:44:33 -0400
Message-ID: <408DC909.7030605@yahoo.com.au>
Date: Tue, 27 Apr 2004 12:44:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Darren Hart <dvhltc@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: sched_domains and Stream benchmark
References: <1N7xQ-7fh-29@gated-at.bofh.it> <m3r7uitr1r.fsf@averell.firstfloor.org> <1083018633.3070.8.camel@farah> <20040427023327.GB11321@colin2.muc.de>
In-Reply-To: <20040427023327.GB11321@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>I noticed your binary ran with N=2000000 which is only sufficient for a
>>2 proc 1 MB cache opteron box according to the documentation on the
> 
> 
> It does not seem to make any difference. 
> 
> 
>>stream faq.  I also noticed wide variation in results (25% or so) when
>>running with 4 threads on a 4 proc opteron on linux-2.6.5-mm5.  Can you
>>provide me with the specs of the system you ran your tests on?
> 
> 
> Yes, mm5 is still broken because it has the "tuned to numasaurus" numa
> scheduler. Run it on a standard (non mm*) kernel or with Ingo's early 
> load balance patch.
> 

Now what is wrong with it? I thought you said it is OK
now that Ingo's balance-on-clone is implemented, and
that you also saw similar variation in results with
numasched?
