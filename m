Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbUKKRke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUKKRke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUKKRjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:39:43 -0500
Received: from relay02.pair.com ([209.68.5.16]:12552 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S262323AbUKKRbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:31:45 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <4193A1EB.4050701@cybsft.com>
Date: Thu, 11 Nov 2004 11:31:23 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark_H_Johnson@Raytheon.com
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-0
References: <OF3F836225.78DCFCB0-ON86256F49.005C260B-86256F49.005C2643@raytheon.com>
In-Reply-To: <OF3F836225.78DCFCB0-ON86256F49.005C260B-86256F49.005C2643@raytheon.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark_H_Johnson@Raytheon.com wrote:
>>i have released the -V0.7.25-0 Real-Time Preemption patch, which can be
>>downloaded from the usual place:
>>
>>   http://redhat.com/~mingo/realtime-preempt/
>>
>>this release includes fixes, new features and latency improvements.
> 
> 
> It may be coincidence, but when I did
>   chrt -p -f 99 2
> (to set IRQ 0 to max RT priority, like the other IRQ's)
> 
> I got the following deadlock.
> 

I tried reproducing this but could not. Of course that doesn't mean
much. :) Also, is this really they way you typed it in? If so, it is
very possible that the pid it tried to chrt was 99 not 2.

kr

