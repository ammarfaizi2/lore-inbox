Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVLLWmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVLLWmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVLLWmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 17:42:20 -0500
Received: from mxsf07.cluster1.charter.net ([209.225.28.207]:19853 "EHLO
	mxsf07.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932218AbVLLWmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 17:42:20 -0500
X-IronPort-AV: i="3.99,245,1131339600"; 
   d="scan'208"; a="1609837396:sNHT52036836"
Message-ID: <439DFC3B.7090609@cybsft.com>
Date: Mon, 12 Dec 2005 16:39:55 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Lee Revell <rlrevell@joe-job.com>, david singleton <dsingleton@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rc5-rt1 will not compile (was Re: 2.6.14-rt15: cannot
 build with !PREEMPT_RT)
References: <1133031912.5904.12.camel@mindpipe>	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>	 <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe>	 <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>	 <20051129093231.GA5028@elte.hu>  <1134090316.11053.3.camel@mindpipe>	 <1134174330.18432.46.camel@mindpipe>  <1134409469.15074.1.camel@mindpipe>	 <1134424143.24145.6.camel@localhost.localdomain>	 <1134425688.17058.5.camel@mindpipe> <1134426179.24145.15.camel@localhost.localdomain>
In-Reply-To: <1134426179.24145.15.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Mon, 2005-12-12 at 17:14 -0500, Lee Revell wrote:
> 
>> The patch had no effect.
> 
> The patch should work for krfoley though.  His errors where the same
> that I had for i386.  I also have it working under x86_64.

Yes it does. Sorry I hadn't responded yet. Thanks. Now just wish I could
get it booted. :)

>> In fact x86-64 does not set CONFIG_RWSEM_XCHGADD_ALGORITHM so this test
>> in include/linux/rwsem.h causes asm/rwsem.h to be included which does
>> not exist on x86-64:
> 
> Yeah OK, you have a different problem.  Did you post your .config?  You
> can send it privately to me if you haven't already posted it.
> 
> -- Steve
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
   kr
