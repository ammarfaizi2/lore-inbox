Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVKVSCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVKVSCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVKVSCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:02:17 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:2983 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S965044AbVKVSCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:02:05 -0500
Message-ID: <43835D01.3020304@nortel.com>
Date: Tue, 22 Nov 2005 12:01:37 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
CC: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Thomas Gleixner <tglx@linutronix.de>,
       pluto@agmk.net, john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: test time-warps [was: Re: 2.6.14-rt13]
References: <20051115090827.GA20411@elte.hu>	 <1132608728.4805.20.camel@cmn3.stanford.edu>	 <20051121221511.GA7255@elte.hu> <20051121221941.GA11102@elte.hu>	 <Pine.LNX.4.58.0511212012020.5461@gandalf.stny.rr.com>	 <20051122111623.GA948@elte.hu> <1132681766.21797.10.camel@cmn3.stanford.edu>
In-Reply-To: <1132681766.21797.10.camel@cmn3.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 18:01:40.0657 (UTC) FILETIME=[CA319A10:01C5EF8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Lopez-Lezcano wrote:

>>Basically if there is an observable and provable warp in the TSC output 
>>then it must not be used for any purpose that is not strictly 
>>per-CPU-ified (such as userspace threads bound to a single CPU, and the 
>>TSC never used between threads).

> Apparently that's the case.

What about periodically re-syncing the TSCs on the cpus?  Are they 
writeable?

Chris

