Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbULIRZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbULIRZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbULIRZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:25:10 -0500
Received: from lax-gate6.raytheon.com ([199.46.200.237]:10709 "EHLO
	lax-gate6.raytheon.com") by vger.kernel.org with ESMTP
	id S261420AbULIRZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:25:05 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFADAD8EC1.8BCE1EC6-ON86256F65.005EFFA6@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 11:22:01 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 11:22:37 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>also, i'd like to take a look at latency traces, if you have them for
>this run.

I could if I had any. The _RT run had NO latency traces > 250 usec (the
limit I had set for the test). The equivalent _PK run had 37 of those
traces. I can rerun the test with a smaller limit to get some if it is
really important. My build of -12 is almost done and we can see what kind
of repeatability / results from the all_cpus trace shows.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

