Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270008AbUJNJf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270008AbUJNJf5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 05:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270009AbUJNJf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 05:35:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13264 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270008AbUJNJfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 05:35:55 -0400
Date: Thu, 14 Oct 2004 11:36:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014093614.GA22598@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014105711.654efc56@mango.fruits.de> <20041014091953.GA21635@elte.hu> <20041014114240.5eae07e5@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014114240.5eae07e5@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> btw: i use:
> 
> chrt -f -p 99 `pidof "IRQ 5"`

ah, indeed, pidof is more robust. Ok, i changed the format from IRQ:5
back to "IRQ 5" in my tree to not break scripts.

	Ingo
