Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264226AbUE2KKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUE2KKo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 06:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUE2KKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 06:10:44 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:604 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264226AbUE2KKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 06:10:43 -0400
Message-ID: <40B8619F.8020108@yahoo.com.au>
Date: Sat, 29 May 2004 20:10:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <7F740D512C7C1046AB53446D372001730182BC35@scsmsx402.amr.corp.intel.com> <20040528225426.GA89095@colin2.muc.de> <40B7E708.1030603@yahoo.com.au> <20040529100600.GA75246@colin2.muc.de>
In-Reply-To: <20040529100600.GA75246@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>We're actually doing the converse of this in the sched-domain
>>scheduler. Processes have a tendancy to follow the interrupts
>>(ie. try to get onto the same CPU as them).
> 
> 
> Hmm? I don't see any code in sched-domain that would care about
> interrupts. What I'm missing?
> 

Well no, what I should have said is wakeups. We do the same
for all wakeups, so there is nothing interrupt specific you
are right.
