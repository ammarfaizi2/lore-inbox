Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbUKBSCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUKBSCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbUKBSCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:02:52 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:24633 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261274AbUKBSCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:02:47 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Date: Tue, 2 Nov 2004 12:00:43 -0600
Message-ID: <OFB38B3DE8.983DDEAD-ON86256F40.0062F170-86256F40.0062F1A5@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/02/2004 12:00:45 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i've uploaded a fixed kernel (-V0.6.8) to:
>
>  http://redhat.com/~mingo/realtime-preempt/

This build appears to run OK and then in the middle of the real time
tests stops doing useful work (during network test).

 - can move mouse & switch displays
 - script checking latency hangs (no errors, apparently stuck in sleep)
 - ps is OK, but top does not work (no display, Ctrl-C gives prompt again)
 - cannot ping the test system from another system (don't get the "no route
message, just no response)
 - Alt-SysRq keys still work
 - eventually the mouse would not switch displays

Rebooted with Alt-SysRq-B.

Sending serial console results separately.
  --Mark

