Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbWJXWuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbWJXWuB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWJXWuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:50:01 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:34097 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1422730AbWJXWuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:50:00 -0400
Message-ID: <453E9892.1010408@de.ibm.com>
Date: Wed, 25 Oct 2006 00:49:54 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <453D0C62.4030601@cfl.rr.com> <453E39B0.2000800@de.ibm.com> <453E7B1F.7020602@cfl.rr.com>
In-Reply-To: <453E7B1F.7020602@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Martin Peschke wrote:
>> Well, the instrumentation "on demand" aspect is half of the truth.
>> A probe inserted through kprobes impacts performance more than static
>> instrumentation.
> 
> True, but given that there are going to be a number of things you might 
> want to instrument at some point, and that at any given time you might 
> only be interested in a few of those, it likely will be better overall 
> to spend some more time only on the few than less time on the many.

Im sure there will be more discussions to sort out which data should be
retrieved through which kind of instrumentation, and to find the right mix.
But I won't dare speculating about the outcome. I am just tossing another
request for data into the discussion (important, in my eyes), along with a
method for retrieving such data (less important, in my eyes).

