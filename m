Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266507AbUGKHJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUGKHJv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 03:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUGKHJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 03:09:51 -0400
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:57283 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266507AbUGKHJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 03:09:34 -0400
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org> <20040710151455.GA29140@devserv.devel.redhat.com> <40F008B0.8020702@kolivas.org> <Pine.LNX.4.58.0407110305420.29060@montezuma.fsmlabs.com>
Message-ID: <cone.1089529747.981348.20820.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Voluntary Kernel Preemption Patch
Date: Sun, 11 Jul 2004 17:09:07 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo writes:

> On Sun, 11 Jul 2004, Con Kolivas wrote:
> 
>> Arjan van de Ven wrote:
>> > On Sun, Jul 11, 2004 at 01:12:28AM +1000, Con Kolivas wrote:
>> >
>> >>I've conducted some of the old fashioned Benno's latency test on this
>> >
>> >
>> > is that the test which skews with irq's disabled ? (eg uses normal
>> > interrupts and not nmi's for it's initial time inrq)
>>
>> It probably is; in which case all these results would be useless, no?
>>
>> http://www.gardena.net/benno/linux/latencytest-0.42.tar.gz
> 
> I think Arjan is referring to rtl_latencytest.c

So to state the bleedingly obvious, this would make these benchmark results 
valid.

If you're interested the command I used was:
./do_tests none 3 256 0 1500000000
as root

Which uses a 1.5Gb file during the disk i/o tests since my machine has 1Gb 
ram.

Con
