Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUH2Bbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUH2Bbm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 21:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268158AbUH2Bbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 21:31:41 -0400
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:7902 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S267556AbUH2BbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 21:31:12 -0400
Message-ID: <413131DD.4060604@bigpond.net.au>
Date: Sun, 29 Aug 2004 11:31:09 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: spaminos-ker@yahoo.com
CC: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin	and
 others)
References: <20040829011936.39122.qmail@web13907.mail.yahoo.com> <1093742542.7078.18.camel@krustophenia.net>
In-Reply-To: <1093742542.7078.18.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2004-08-28 at 21:19, spaminos-ker@yahoo.com wrote:
> 
>>--- Lee Revell <rlrevell@joe-job.com> wrote:
>>
>>>Is this an SMP machine?  There were problems with that version of the
>>>voluntary preemption patches on SMP.  The latest version, Q3, should fix
>>>these.
>>>
>>
>>No, it's a single CPU Athlon 1800+, the kernel is compiled in with support for
>>SMP system, but that should not have any impact.
>>
> 
> 
> I believe people were also having problems running SMP kernels with the
> VP patches on UP.  Try the latest version. Q3 as of this writing.

Nicolas,
	I'll generate a combined patch and let you know when it's ready.  In 
the mean time, could you try increasing the "base_promotion_interval" to 
about twice the time slice size?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

