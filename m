Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWINVFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWINVFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWINVFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:05:51 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:9913 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id S1751058AbWINVFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:05:50 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Michel Dagenais <michel.dagenais@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Bligh <mbligh@mbligh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, fche@redhat.com
In-Reply-To: <20060914201448.GA7357@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
	 <450971CB.6030601@mbligh.org> <20060914174306.GA18890@elte.hu>
	 <4509B5A4.2070508@mbligh.org>  <20060914201448.GA7357@elte.hu>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 17:05:06 -0400
Message-Id: <1158267906.5068.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Poly-FromMTA: (saorge.dgi.polymtl.ca [132.207.169.35]) at Thu, 14 Sep 2006 21:05:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the question is: what is more maintainance, hundreds of static 
> tracepoints (with long parameter lists) all around the (core) kernel, or 
> hundreds of detached dynamic rules that need an update every now and 
> then? [but of which most would still be usable even if some of them 
> "broke"] To me the answer is clear: having hundreds of tracepoints 
> _within_ the source code is higher cost. But please prove me wrong :-)

Actually I rarely find that any of the 70 000 printk is such a huge
nuisance to code readability. They may even help understand what is
going on in a code area you are less familiar with.

