Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUJUJVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUJUJVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUJUJRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:17:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23504 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268819AbUJUJRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:17:32 -0400
Date: Thu, 21 Oct 2004 11:18:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021091850.GA29183@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

>    One of the signs that there's real trouble in here can be seen on
> the following complete dmesg output (which was even a miracle to be
> captured at all). This shows the complete bootstrap and init sequences
> and at the end one fatal crash while plugging an USB flash memory
> stick (usb-storage). This has been already reported earlier yesterday,
> but I just want to make it here, as the evidence-at-hand.
> 
>    After this precise occurence, the system becomes very flaky,
> unreliable and often ends up freezing to death.

for the sake of testing could you disable CONFIG_USB and see whether the
instability is truly directly related to the USB crash, as you suspect?
Such a kernel crash can often destabilize other parts of the kernel.

	Ingo
