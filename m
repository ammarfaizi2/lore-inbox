Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbUKJP5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbUKJP5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 10:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUKJP5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 10:57:39 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:44250 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261955AbUKJP5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 10:57:38 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
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
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF6B443F60.4896500B-ON86256F48.00567207@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 10 Nov 2004 09:57:01 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/10/2004 09:57:03 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> [...] I also noticed that /proc/sys/kernel/preempt_wakeup_timing was
>> removed at .20 but not sure if that was deliberate. [...]
>
>yeah, this was deliberate - it's a side-effect of separating it from the
>other timing options.

OK. So maybe I didn't understand what you said previously. Now, if I build
to get maximum-latency wakeup values, I can't get the IRQ off or
preempt off timing and traces? If that's not true, how do I switch
between the different sampling methods?

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

