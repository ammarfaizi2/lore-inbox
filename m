Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbUKLRc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUKLRc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 12:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUKLRae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 12:30:34 -0500
Received: from relay01.pair.com ([209.68.5.15]:26635 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261465AbUKLR2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 12:28:10 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <4194F294.4000908@cybsft.com>
Date: Fri, 12 Nov 2004 11:27:48 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shane Shrybman <shrybman@aei.ca>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>	 <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>	 <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>	 <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>	 <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>	 <20041111215122.GA5885@elte.hu> <1100269881.10971.6.camel@mars>
In-Reply-To: <1100269881.10971.6.camel@mars>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Shrybman wrote:
> On Thu, 2004-11-11 at 16:51, Ingo Molnar wrote:
> 
>>i have released the -V0.7.25-1 Real-Time Preemption patch, which can be
>>downloaded from the usual place:
>>
>>    http://redhat.com/~mingo/realtime-preempt/
>>
>>this is a fixes-only release that resolves a couple of bugs that slipped
>>into -V0.7.25-0:
>>
>> - lockup/deadlock fix: make debug_direct_keyboard default to 0. It is
>>   only a debug helper to be used for development, it was never intended
>>   to be enabled. This fix should resolve the bugs reported by Gunther
>>   Persoons and Mark H. Johnson.
> 
> 
> Ahh, that probably explains the problems I had with it!
> 
> V0.7.25-1 has been stable here with the ivtv driver for 11 hrs. No sign
> of the ide dma time out issue either. Out of curiosity, do we know what
> solved that problem?
> 
> Regards,
> 
> Shane
> 

What sort of errors did you get about the ide dma timeouts?

kr

