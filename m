Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269508AbUJSVKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269508AbUJSVKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269924AbUJSVBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:01:20 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:35594 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S269538AbUJSUwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:52:40 -0400
Message-ID: <41757E88.2030802@stud.feec.vutbr.cz>
Date: Tue, 19 Oct 2004 22:52:24 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
In-Reply-To: <20041019124605.GA28896@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -U6 Real-Time Preemption patch:
>  
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U6
> 
>   [...]
> - deadlock bug: fix networking deadlock reported by Matthew L Foster.
>   Restructured the way the RT-RCU locking of ptype_lock is done - it's
>   cleaner and more obvious now (besides being correct). This could also
>   fix the deadlock reported by Michal Schmidt.

Yes, this fixed the deadlock for me.
I'm now going to try -U7.

Michal
