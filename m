Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbUKPQTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUKPQTT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUKPQTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:19:19 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:5296 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262019AbUKPQSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:18:49 -0500
To: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Date: Tue, 16 Nov 2004 10:15:37 -0600
Message-ID: <OF9912C2F0.D5088A51-ON86256F4E.005951F3-86256F4E.0059520E@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/16/2004 10:15:44 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From what I can tell, it was attempting to test the NMI watchdog
>when it failed.

Confirmed, clean boot when I removed
  nmi_watchdog=1 profile=2
from the boot parameters. Will be doing some tests without it.

   --Mark

