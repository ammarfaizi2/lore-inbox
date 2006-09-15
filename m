Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWIOSK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWIOSK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWIOSK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:10:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:21936 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751371AbWIOSKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:10:33 -0400
Message-ID: <450AEC92.7090409@us.ibm.com>
Date: Fri, 15 Sep 2006 13:10:26 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>	 <20060914135548.GA24393@elte.hu>	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>	 <20060914171320.GB1105@elte.hu>	 <Pine.LNX.4.64.0609141935080.6761@scrub.home>	 <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com>	 <1158320406.29932.16.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151339190.6761@scrub.home>	 <1158323938.29932.23.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain>
In-Reply-To: <1158327696.29932.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Consistency for user space ?
>   

With several other trace tools being implemented for the kernel, there 
is a great problem with consistencies among these tool.  It is my 
opinion that trace are of very little use to _most_ people with out the 
availability of post-processing tools to analyses these trace.  While I 
wont say that we need one all powerful solution, it would be good if all 
solutions would at least be able to talk to the same post-processing 
facilities in user-space.  Before LTTng is even considered into the 
kernel, there need to be discussion to determine if the trace mechanism 
being propose is suitable for all people interested in doing trace 
analysis.  The fact the there also exist tool like LKET and LKST seem to 
suggest that there other things to be considered when it comes to 
implementing a trace mechanism that everyone would be happy with.

It would also be useful for all the trace tool to implement the same 
probe points so that post-processing tools can be interchanged between 
the various trace implementations.


-JRS
