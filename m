Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUKTUXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUKTUXa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 15:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUKTUXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 15:23:24 -0500
Received: from relay00.pair.com ([209.68.1.20]:53513 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S263173AbUKTUXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 15:23:12 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <419FA7AD.3090004@cybsft.com>
Date: Sat, 20 Nov 2004 14:23:09 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu>
In-Reply-To: <20041118164612.GA17040@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.7.29-0 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 

I have some latency test results from -V0.7.29-4 generated using the rtc 
histograms and realfeel. The test runs were just over an hour under 
heavy load from stress-kernel. One is from a slower 450 UP system and 
one is from a 933 SMP system. I will be doing more testing but these are 
a start.

http://www.cybsft.com/testresults/histograms/up450test1.hist.png

http://www.cybsft.com/testresults/histograms/up450test1.hist.png

kr
