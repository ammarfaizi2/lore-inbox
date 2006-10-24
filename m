Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbWJXUoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbWJXUoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbWJXUoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:44:10 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:7004 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S965187AbWJXUoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:44:08 -0400
Message-ID: <453E7B1F.7020602@cfl.rr.com>
Date: Tue, 24 Oct 2006 16:44:15 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Martin Peschke <mp3@de.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <453D0C62.4030601@cfl.rr.com> <453E39B0.2000800@de.ibm.com>
In-Reply-To: <453E39B0.2000800@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2006 20:44:21.0892 (UTC) FILETIME=[2F23DC40:01C6F7AD]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14772.000
X-TM-AS-Result: No--3.773100-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke wrote:
> Well, the instrumentation "on demand" aspect is half of the truth.
> A probe inserted through kprobes impacts performance more than static
> instrumentation.

True, but given that there are going to be a number of things you might 
want to instrument at some point, and that at any given time you might 
only be interested in a few of those, it likely will be better overall 
to spend some more time only on the few than less time on the many.


