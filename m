Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbULAMup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbULAMup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 07:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbULAMuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 07:50:44 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:62542 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261388AbULAMuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 07:50:37 -0500
Message-ID: <32836.192.168.1.5.1101905384.squirrel@192.168.1.5>
In-Reply-To: <20041201112520.GA20919@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93>
    <20041129111634.GB10123@elte.hu>
    <41358.195.245.190.93.1101734020.squirrel@195.245.190.93>
    <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu>
    <48590.195.245.190.94.1101810584.squirrel@195.245.190.94>
    <20041130131956.GA23451@elte.hu>
    <17532.195.245.190.94.1101829198.squirrel@195.245.190.94>
    <20041201103251.GA18838@elte.hu> <20041201112520.GA20919@elte.hu>
Date: Wed, 1 Dec 2004 12:49:44 -0000 (WET)
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 01 Dec 2004 12:50:36.0562 (UTC) FILETIME=[5A77B720:01C4D7A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>> New XRUN traces are attached, while running RT-V0.7.31-15 now.
>> However, I don't seem to get any notorious difference on the results,
>> since previous ones. All latencies traced ca. 26-27 usecs.
>
> another thing: could you try the latest jackd CVS tree too? I found
> spurious xruns in 99-0 (the last official release), while with 99-11 i
> dont see any xruns on my box, up until i completely saturate CPU time.
>
> I.e. both latest -RT kernels are needed for this (earlier RT kernels,
> prior the PI fixes still generated lots of xruns even with latest jack
> CVS), and latest jack CVS is needed.
>

I am using the latest-as-it-could-be jack CVS snapshot, as handed by Jack
O'Quin, since sourceforge's CVS service has been broken for a while.

The latest of my last report is 0.99.15.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

