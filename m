Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWINUZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWINUZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWINUZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:25:59 -0400
Received: from dvhart.com ([64.146.134.43]:55265 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751135AbWINUZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:25:58 -0400
Message-ID: <4509BAD4.8010206@mbligh.org>
Date: Thu, 14 Sep 2006 13:25:56 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu>
In-Reply-To: <20060914171320.GB1105@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if there are lots of tracepoints (and the union of _all_ useful 
> tracepoints that i ever encountered in my life goes into the thousands) 
> then the overhead is not zero at all.
> 
> also, the other disadvantages i listed very much count too. Static 
> tracepoints are fundamentally limited because:
> 
>   - they can only be added at the source code level
> 
>   - modifying them requires a reboot which is not practical in a
>     production environment
> 
>   - there can only be a limited set of them, while many problems need
>     finegrained tracepoints tailored to the problem at hand
> 
>   - conditional tracepoints are typically either nonexistent or very
>     limited.
> 
> for me these are all _independent_ grounds for rejection, as a generic 
> kernel infrastructure.

I don't think anyone is saying that static tracepoints do not have their
limitations, or that dynamic tracepointing is useless. But that's not
the point ... why can't we have one infrastructure that supports both?
Preferably in a fairly simple, consistent way.

M.
