Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbULNEm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbULNEm4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbULNEm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:42:56 -0500
Received: from relay03.pair.com ([209.68.5.17]:35077 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S261402AbULNEmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 23:42:54 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41BE6F48.3030006@cybsft.com>
Date: Mon, 13 Dec 2004 22:42:48 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
CC: Ingo Molnar <mingo@elte.hu>, Mark_H_Johnson@raytheon.com,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
References: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com>	 <1102897004.31218.8.camel@cmn37.stanford.edu>	 <20041213064719.GA3681@elte.hu> <1102985171.10967.713.camel@cmn37.stanford.edu>
In-Reply-To: <1102985171.10967.713.camel@cmn37.stanford.edu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Lopez-Lezcano wrote:
> On Sun, 2004-12-12 at 22:47, Ingo Molnar wrote:
> 
>>* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
>>
>>
>>>Something that just happened to me: running 0.7.32-14
>>>(PREEMPT_DESKTOP) and trying to install 0.7.32-19 from a custom built
>>>rpm package completely hangs the machine (p4 laptop - I tried twice).
>>>No clues left behind. If I boot into 0.7.32-9 I can install 0.7.32-19
>>>with no problems. 
>>
>>does 0.7.32-19 work better if you reverse (patch -R) the loop.h and
>>loop.c bits (see below)?
> 
> 
> Running 0.7.32-19 (no changes) I managed to install 0.7.32-20 with no
> problems... probably a problem in -14 that was somehow fixed in later
> releases. 
> 
> -- Fernando

Possibly. I have had the occasional problem with running make install 
locking one of my systems. Rebooting and running make install again 
works fine in my case. It is by no means a regular occurrence, even 
installing 2 or 3 new kernels daily on 3 different machines.

kr
