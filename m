Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUJYUnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUJYUnV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbUJYUkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:40:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17873 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261989AbUJYUhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:37:00 -0400
Date: Mon, 25 Oct 2004 22:38:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025203807.GB27865@elte.hu>
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417D4B5E.4010509@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Actually pertaining to V0.2. I just got my UP system booted up on V0.2
> and got this in the log. I did notice that this is not new to this
> release. It has been here at least since U10.3. Sorry I didn't catch
> it sooner.
> 
> Oct 25 13:31:56 daffy kernel: IRQ#11 thread RT prio: 43.
> Oct 25 13:31:56 daffy kernel: ip/2432: BUG in enable_irq at 
> kernel/irq/manage.c:112

this is pretty harmless and has been happening in -mm for some time. The
e100 device will work fine afterwards.

	Ingo
