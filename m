Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbUKJOUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbUKJOUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbUKJOR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:17:26 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:71 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261893AbUKJONg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:13:36 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Date: Wed, 10 Nov 2004 08:12:22 -0600
Message-ID: <OF4859D245.BB8FA90D-ON86256F48.004E0938-86256F48.004E0960@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/10/2004 08:12:28 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
>
>> [3] I am not so sure that the latency tracing works. I do not get any
>> trace output, even if I set preempt_max_latency to zero.
>
>What is the value of preempt_thresh?
It was zero at boot time. Now that I check, set it somewhere to 200.
Setting it back to zero, I now see that I have some extremely
small reports, max so far is 63 usec. Will run my big test again
to see what turns up.

  --Mark

