Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUKCBD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUKCBD4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUKCBDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:03:55 -0500
Received: from lax-gate6.raytheon.com ([199.46.200.237]:2957 "EHLO
	lax-gate6.raytheon.com") by vger.kernel.org with ESMTP
	id S261452AbUKBVkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:40:36 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Date: Tue, 2 Nov 2004 15:39:21 -0600
Message-ID: <OF5BA77D51.DBEBBD30-ON86256F40.0076F564-86256F40.0076F5A0@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/02/2004 03:39:30 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>was this already in the default bootup, or only after the crash
>happened?
Not quite a "crash", but definitely after I noticed the system no
longer doing any useful work. As I said before, it was as if anything
to do with timers was not working (e.g., sleep 1s).

>Does this also happen if you chrt ksoftirqd to FIFO prio 1?
>Does the 'LOC' count increase for both cpus in /proc/interrupts?

It will be an hour or so before I can try either of these,
I have a build in progress. I can check both of these with the new
build (or the old one if you want that too).

  --Mark

