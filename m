Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbUKLOfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUKLOfL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 09:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUKLOfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 09:35:11 -0500
Received: from mail.aei.ca ([206.123.6.14]:11754 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262541AbUKLOed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 09:34:33 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
From: Shane Shrybman <shrybman@aei.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041111215122.GA5885@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
	 <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
	 <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
	 <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
	 <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu>
Content-Type: text/plain
Message-Id: <1100269881.10971.6.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 12 Nov 2004 09:31:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 16:51, Ingo Molnar wrote:
> i have released the -V0.7.25-1 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes-only release that resolves a couple of bugs that slipped
> into -V0.7.25-0:
> 
>  - lockup/deadlock fix: make debug_direct_keyboard default to 0. It is
>    only a debug helper to be used for development, it was never intended
>    to be enabled. This fix should resolve the bugs reported by Gunther
>    Persoons and Mark H. Johnson.

Ahh, that probably explains the problems I had with it!

V0.7.25-1 has been stable here with the ivtv driver for 11 hrs. No sign
of the ide dma time out issue either. Out of curiosity, do we know what
solved that problem?

Regards,

Shane

