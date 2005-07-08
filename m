Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVGHKzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVGHKzj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVGHKzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:55:36 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:56686 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262528AbVGHKzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:55:25 -0400
Message-ID: <31897.195.245.190.94.1120820026.squirrel@www.rncbc.org>
In-Reply-To: <20050708095600.GA5910@elte.hu>
References: <1119375988.28018.44.camel@cmn37.stanford.edu>
    <1120256404.22902.46.camel@cmn37.stanford.edu>
    <20050703133738.GB14260@elte.hu>
    <1120428465.21398.2.camel@cmn37.stanford.edu>
    <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>
    <20050707194914.GA1161@elte.hu>
    <49943.192.168.1.5.1120778373.squirrel@www.rncbc.org>
    <57445.195.245.190.94.1120812419.squirrel@www.rncbc.org>
    <20050708085253.GA1177@elte.hu>
    <28798.195.245.190.94.1120815616.squirrel@www.rncbc.org>
    <20050708095600.GA5910@elte.hu>
Date: Fri, 8 Jul 2005 11:53:46 +0100 (WEST)
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-11 glitches [no more]
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 08 Jul 2005 10:55:20.0740 (UTC) FILETIME=[88C84640:01C583AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
>
>> OTOH, I'll take this chance to show you something that is annoying me
>> for quite some time. Just look to the attached chart where I've marked
>> the spot with an arrow and a question mark. Its just one example of a
>> strange behavior/phenomenon while running the jack_test4.2 test on
>> PREEMPT_RT kernels: the CPU usage, which stays normally around 50%,
>> suddenly jumps to 60% steady, starting at random points in time but
>> always some time after the test has been started. Note that this
>> randomness surely adds to the the slight differences found on the
>> above results.
>
> how long does this condition persist?

On all of my extensive tests, it persists on all of the remaining
jack_test4 time span, doesn't matter how long it is.

I'll look later into your profiling and tracing instructions.  Many thanks
for the directions.

Seeya.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

