Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269429AbUJSOsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269429AbUJSOsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 10:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269433AbUJSOsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 10:48:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36283 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269429AbUJSOsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 10:48:14 -0400
Date: Tue, 19 Oct 2004 16:46:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019144642.GA6512@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019124605.GA28896@elte.hu>
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

> i have released the -U6 Real-Time Preemption patch:
>  
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U6

i've re-released the patch because shortly after releasing it i found a
false-positive in the deadlock-detector that was triggering in oowriter. 

The latest patch is thus:

 $ md5sum realtime-preempt-2.6.9-rc4-mm1-U6
 9fd546bdd2d45ff1a8d5a88160135170  realtime-preempt-2.6.9-rc4-mm1-U6

if you've got the earlier one and have CONFIG_RWSEM_DEADLOCK_DETECT
enabled then please download the new patch.

	Ingo
