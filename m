Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbULDXlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbULDXlm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 18:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbULDXlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 18:41:42 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:32330 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261196AbULDXlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 18:41:37 -0500
Message-ID: <32796.192.168.1.5.1102203504.squirrel@192.168.1.5>
In-Reply-To: <20041204224641.GA14850@elte.hu>
References: <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
    <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
    <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
    <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
    <20041203205807.GA25578@elte.hu>
    <32786.192.168.1.5.1102199522.squirrel@192.168.1.5>
    <20041204224641.GA14850@elte.hu>
Date: Sat, 4 Dec 2004 23:38:24 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
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
X-OriginalArrivalTime: 04 Dec 2004 23:41:36.0316 (UTC) FILETIME=[CB226FC0:01C4DA5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> Rui Nuno Capela wrote:
>
>> Ingo Molnar wrote:
>> >
>> > i have released the -V0.7.32-0 Real-Time Preemption patch, which can
>> > be downloaded from the usual place:
>> >
>>
>> I have a bug to report, it shows on both of my machines (SMP and UP)
>> now running RT-V0.7.32-2. It seems to be present also on previous RT
>> releases, and don't even know if it's upstream.
>>
>> When one usb-storage flash stick is first time unplugged:
>
> hm, doesnt seem to be directly related to -RT. Could you try the vanilla
> -rc2-mm3 kernel, does it trigger there too?
>

No, it doesn't. Just tested on 2.6.10-rc2-mm3 (vanilla) and nothing wrong
happens. I can plug and unplug the USB flashram stick, and again, and
again, and everything stays fine.

On 2.6.10-rc2-mm3-RT-V0.7.32-2 I get trouble after the first time I unplug
the thingie. From then on I rather not touch it back again ;)

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

