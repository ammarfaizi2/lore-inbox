Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbUKPMGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUKPMGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 07:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbUKPMGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 07:06:31 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:11037 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261961AbUKPMGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 07:06:22 -0500
Message-ID: <18732.195.245.190.93.1100606711.squirrel@195.245.190.93>
In-Reply-To: <20041116104143.GA31090@elte.hu>
References: <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu>
    <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu>
    <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu>
    <61930.195.245.190.94.1100529227.squirrel@195.245.190.94>
    <20041115161159.GA32580@elte.hu>
    <33583.195.245.190.93.1100537554.squirrel@195.245.190.93>
    <32825.192.168.1.5.1100558154.squirrel@192.168.1.5>
    <20041116104143.GA31090@elte.hu>
Date: Tue, 16 Nov 2004 12:05:11 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
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
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 16 Nov 2004 12:06:20.0020 (UTC) FILETIME=[AED95340:01C4CBD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> Rui Nuno Capela wrote:
>
>> Already testing with RT-0.7.26-5 now. No good. Same lockup behavior on
>> alsa shutdown, altought not always, but very frequently. Nothing comes
>> out via serial console. Not even SysRq is of any help, pretty hard
>> these lockups are.
>
> i'm rebasing to -rc2-mm1 currently, it should be completed today and
> we'll see whether those ALSA problems are upstream related.
>
> is it stable if you dont unload the ALSA modules?
>

Yes, it looks like the stabliest of the RTs I've tested to date. Trouble
only comes when '/etc/init.d/alsasound stop' is called.

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

