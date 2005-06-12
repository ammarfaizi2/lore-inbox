Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVFLTay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFLTay (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVFLTaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:30:15 -0400
Received: from opersys.com ([64.40.108.71]:39436 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261180AbVFLTSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 15:18:32 -0400
Message-ID: <42AC8D00.4030809@opersys.com>
Date: Sun, 12 Jun 2005 15:29:04 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu> <42AB662B.4010104@opersys.com> <20050612061108.GA4554@elte.hu>
In-Reply-To: <20050612061108.GA4554@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> ok, this method should work fine. I suspect you increased the parport 
> IRQ's priority to the maximum on the PREEMPT_RT kernel, correct? Was 
> there any userspace thread on the target system (receiving the parport 
> request and sending the reply), or was it all done in a kernelspace 
> parport driver?

This is all done in kernelspace. I'll check with Kristian for the
rest. In the mean time, let me know if you have any recommendations
based on the fact that it's indeed in the kernel.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

