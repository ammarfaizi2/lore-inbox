Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWAWT3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWAWT3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWAWT3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:29:30 -0500
Received: from smtp-out.google.com ([216.239.45.12]:19114 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964907AbWAWT33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:29:29 -0500
Message-ID: <43D52E6F.7040808@google.com>
Date: Mon, 23 Jan 2006 11:28:47 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C5BD8F.3000307@bigpond.net.au> <43C5BE4A.9030105@google.com> <200601121739.17886.kernel@kolivas.org>
In-Reply-To: <200601121739.17886.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks and looks like the results are in from 2.6.14-rc2-mm1 with the patch 
> backed out.
> 
> Drumroll....
> 
> http://test.kernel.org/perf/kernbench.moe.png
> 
> The performance goes back to a range similar to 2.6.14-rc1-mm1 (see 
> 2.6.14-rc2-mm1 + 20328 in blue). Unfortunately this does implicate this 
> patch. Can we put it back into -mm only and allow Peter's tweaks/fixes to go 
> on top and have it tested some more before going upstream?

Hmm. Looks like we didn't get this as fixed up as I thought. Moe seems 
to be fixed (16x NUMA-Q), but elm3b132 is not (it's 4x, flat SMP ia32).
Look at the latest graphs ....

Is it possible it only got fixed for NUMA boxes?

M.

