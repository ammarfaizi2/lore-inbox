Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUKVTIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUKVTIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbUKVTGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:06:22 -0500
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:54173 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S262263AbUKVTEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:04:00 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
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
Message-ID: <OFA1E6AFAB.5C0C20E9-ON86256F54.006845EC@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 22 Nov 2004 13:00:55 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/22/2004 01:03:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [2] variety of long > 1 msec wakeup latencies (see below)
> [3] primary long latencies with ksoftirqd/[01] and IRQ 10 tasks
Never mind on the long latencies.

I forgot to set udma2 on the disk drive. Setting that  changed
the wakeup latencies back to the sub 100 usec range.

Will be trying the (non wakeup) traces next.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

