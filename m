Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbUKDQ1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbUKDQ1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbUKDQ1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:27:17 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:30893 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S262281AbUKDQ1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:27:13 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF5DB3F102.6D3B4834-ON86256F42.00598BFD@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 4 Nov 2004 10:22:02 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/04/2004 10:22:09 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>what priority does events/0 and events/1 have? keventd handles part of
>the mouse/keyboard workload.
The default priorities and not RT.

ps -eo pid,pri,rtprio,cmd
...
  6  34    -  [events/0]
  7  34    -  [events/1]
...
I can set those as well but then I'd probably have to follow with
the X server and everything else in the chain. The starvation problem
ripples across the system.

Will try the patch shortly and get back on the results later today.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

