Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbUKHWWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUKHWWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUKHWWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:22:18 -0500
Received: from brown.brainfood.com ([146.82.138.61]:20356 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261269AbUKHWWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:22:02 -0500
Date: Mon, 8 Nov 2004 16:21:27 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.19
In-Reply-To: <20041108091619.GA9897@elte.hu>
Message-ID: <Pine.LNX.4.58.0411081620400.1229@gradall.private.brainfood.com>
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
 <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu>
 <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
 <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
 <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
 <20041108091619.GA9897@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Ingo Molnar wrote:

>
> i have released the -V0.7.19 Real-Time Preemption patch, which can be
> downloaded from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> this release includes fixes only.
>
> Changes since -V0.7.18:
>
>  - fixed a merge bug introduced in -V0.7.18, breaking bit-spinlocks used
>    by ext3's journalling code. This could/should fix the kjournald crash
>    reported by Adam Heath, Gunther Persoons and Eran Mann. Bug triggered
>    on !SMP kernels only.

The last kernel I tried was v0.7.13, so I doubt it was a recent introduction.

Will try something newer soon.
