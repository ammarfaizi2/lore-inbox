Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264487AbUKANzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbUKANzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUKANzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:55:14 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:19964 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S263051AbUKANy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:54:57 -0500
Message-Id: <200411011354.iA1Dsleg008831@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4] 
In-reply-to: Your message of "Mon, 01 Nov 2004 14:42:35 +0100."
             <20041101134235.GA18009@elte.hu> 
Date: Mon, 01 Nov 2004 08:54:47 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.152.250.245] at Mon, 1 Nov 2004 07:54:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>* Florian Schmidt <mista.tapas@gmx.net> wrote:
>
>> new max. jitter: 4.3% (41 usec)
>> new max. jitter: 4.9% (47 usec)
>
>a couple of conceptual questions: why does rtc_wakeup poll() on
>/dev/rtc? Shouldnt a read() be enough?

i suggested to florian that it should model jackd's behaviour as
closely as possible. because jackd requires duplex operation, using
just read/write doesn't work.


