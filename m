Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422748AbWAMRxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422748AbWAMRxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422749AbWAMRxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:53:38 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:36613 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1422748AbWAMRxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:53:37 -0500
Message-ID: <43C7E96D.7000003@shadowen.org>
Date: Fri, 13 Jan 2006 17:54:53 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Andy Whitcroft <apw@shadowen.org>, Con Kolivas <kernel@kolivas.org>,
       Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au> <43C6A24E.9080901@google.com> <43C6B60E.2000003@bigpond.net.au> <43C6D636.8000105@bigpond.net.au> <43C75178.80809@bigpond.net.au> <43C7D4D1.10200@shadowen.org>
In-Reply-To: <43C7D4D1.10200@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Peter Williams wrote:
> 
> 
>>Attached is a new patch to fix the excessive idle problem.  This patch
>>takes a new approach to the problem as it was becoming obvious that
>>trying to alter the load balancing code to cope with biased load was
>>harder than it seemed.
> 
> 
> Ok.  Tried testing different-approach-to-smp-nice-problem against the
> transition release 2.6.14-rc2-mm1 but it doesn't apply.  Am testing
> against 2.6.15-mm3 right now.  Will let you know.

Doesn't appear to help if I am analysing the graphs right.  Martin?

Also tried to back out the original patch against the 2.6.15-mm3 tree
but that also won't apply (2 rejects).  Peter?

-apw
