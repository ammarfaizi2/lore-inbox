Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbUJ0Xmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbUJ0Xmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUJ0Xin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 19:38:43 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:41386 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262647AbUJ0Xfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 19:35:30 -0400
Message-ID: <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
In-Reply-To: <20041027211957.GA28571@elte.hu>
References: <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu>
    <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
    <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
    <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
    <20041027135309.GA8090@elte.hu>
    <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
    <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu>
Date: Thu, 28 Oct 2004 00:31:53 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 27 Oct 2004 23:35:21.0350 (UTC) FILETIME=[9FF0AA60:01C4BC7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>> ok, i've uploaded RT-V0.4.2 which has more of the same: it fixes other
>> missed preemption checks. Does it make any difference to the xruns on
>> your UP box?
>
> uploaded RT-V0.4.3 - there was a thinko in the latency tracer that
> caused early boot failures.
>

Yes, the xrun rate has decreased, slightly. RT-V0.4.3 is now ranking under
10 per 5 min (~2/min), with jackd -R -r44100 -p128 -n2, fluidsynth x 6.

Better still, but not to par as RT-U3, under the very same conditions.

Cya.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

