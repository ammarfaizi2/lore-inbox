Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266529AbUGKJaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266529AbUGKJaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 05:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUGKJaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 05:30:21 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:23686 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266529AbUGKJaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 05:30:17 -0400
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org> <20040710151455.GA29140@devserv.devel.redhat.com> <40F008B0.8020702@kolivas.org> <20040711091807.GA16087@elte.hu>
Message-ID: <cone.1089538195.567633.20820.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Voluntary Kernel Preemption Patch
Date: Sun, 11 Jul 2004 19:29:55 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> 
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
>> >>I've conducted some of the old fashioned Benno's latency test on this 
>> >
>> >
>> >is that the test which skews with irq's disabled ? (eg uses normal
>> >interrupts and not nmi's for it's initial time inrq)
>> 
>> It probably is; in which case all these results would be useless, no?
>> 
>> http://www.gardena.net/benno/linux/latencytest-0.42.tar.gz
> 
> did you run latencytest as root?

I wish it were that simple to fix it. Here's what I said later in this 
thread:

---
If you're interested the command I used was:
./do_tests none 3 256 0 1500000000
as root

Which uses a 1.5Gb file during the disk i/o tests since my machine has 1Gb 
ram.
---

Con

