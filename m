Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUJFD1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUJFD1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUJFD1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:27:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5003 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266810AbUJFD1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:27:20 -0400
Message-ID: <4163660A.4010804@pobox.com>
Date: Tue, 05 Oct 2004 23:27:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org> <20041006031726.GK26820@dualathlon.random>
In-Reply-To: <20041006031726.GK26820@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> So I disagree with your claim that preempt risks to hide inefficient
> code, there are many other (probably easier) ways to detect inefficient
> code than to check the latencies.


You're ignoring the argument :)

If users and developers are presented with the _impression_ that long 
latency code paths don't exist, then nobody is motivated to profile them 
(with any tool), much less fix them.

	Jeff


