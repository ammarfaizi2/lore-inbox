Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUCaCbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 21:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbUCaCbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 21:31:04 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:12926 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261682AbUCaCa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 21:30:59 -0500
Message-ID: <406A2D5D.6020508@yahoo.com.au>
Date: Wed, 31 Mar 2004 12:30:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Erich Focht <efocht@hpce.nec.com>,
       mbligh@aracnet.com, jun.nakajima@intel.com, ricklind@us.ibm.com,
       akpm@osdl.org, kernel@kolivas.org, rusty@rustcorp.com.au,
       anton@samba.org, lse-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] sched-2.6.5-rc3-mm1-A0
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <200403300030.25734.efocht@hpce.nec.com> <4069384B.9070108@yahoo.com.au> <200403301204.14303.efocht@hpce.nec.com> <20040330125805.4c62bf36.ak@suse.de> <20040330160336.GA2508@elte.hu>
In-Reply-To: <20040330160336.GA2508@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>  - use sync wakeups for parent-wakeup. This makes a single-task strace
>    execute on only one CPU on SMP, which is precisely what we want. It
>    should also be a speedup for a number of workloads where the parent
>    is actively wait4()-ing for the child to exit.

Nice
