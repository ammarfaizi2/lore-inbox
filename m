Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbUJ1OS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUJ1OS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUJ1OSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:18:25 -0400
Received: from mail4.utc.com ([192.249.46.193]:9633 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S261319AbUJ1OOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:14:33 -0400
Message-ID: <4180FEBB.5020802@cybsft.com>
Date: Thu, 28 Oct 2004 09:14:19 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041027130359.GA6203@elte.hu>
In-Reply-To: <20041027130359.GA6203@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.4 Real-Time Preemption patch, which can be
> downloaded from:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 

I have been having problems on my UP system at home with all of the more 
recent patches (since U10.X). Some would boot and then the networking 
was severely busted (slowdowns, hangs, etc.), some would not even boot. 
V0.4.3 was of the no boot variety. Just for grins I disabled kudzu, and 
the thing boots fine with no networking or other problems. This very 
well may have been a fluke, but I have successfully booted this kernel 
twice now. It did hang on a reboot at the point when it should have been 
doing the actual reboot and I had to press the button. I didn't have 
time this morning to turn kudzu back on to see if was just a fluke that 
it didn't boot the first time. Not sure what, if anything, this means, 
but V0.4.3 is running very nicely on my UP system with no lag or 
noticeable problems.

kr
