Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbUJYOXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUJYOXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUJYOVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:21:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9396 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261395AbUJYOPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:15:16 -0400
Date: Mon, 25 Oct 2004 16:16:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025141628.GA14282@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com> <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu> <20041025152458.3e62120a@mango.fruits.de> <20041025132605.GA9516@elte.hu> <20041025160330.394e9071@mango.fruits.de> <20041025141008.GA13512@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025141008.GA13512@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> ok, i've added it and uploaded -V0.2 together with another fix: there
> was a scheduler recursion possible via the delayed-put mechanism using
> workqueues - now it's using its own separate lists and per-CPU
> threads.

-V0.2 seems to behave quite well on my testboxes - i'm unable to
reproduce the selinux boot hang anymore.

	Ingo
