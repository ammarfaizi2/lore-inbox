Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbUKBTqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUKBTqC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUKBTqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:46:01 -0500
Received: from mail4.utc.com ([192.249.46.193]:32900 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S261362AbUKBTlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:41:16 -0500
Message-ID: <4187E2BA.8020609@cybsft.com>
Date: Tue, 02 Nov 2004 13:40:42 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
References: <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu> <1099324040.3337.32.camel@thomas> <20041102150634.GA24871@elte.hu> <4187C95F.5030808@cybsft.com> <20041102193756.GA3053@elte.hu>
In-Reply-To: <20041102193756.GA3053@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>This one initially booted fine on my SMP workstation at the office.
>>Ran for about 1 hr. 10 mins. then locked with no indications as to
>>why.  [...]
> 
> 
> soft hang or hard hang? In any case, the freshly uploaded -V0.6.9 kernel
> both fixes one more deadlock and extends deadlock-detection to virtually
> every locking object in Linux so it would be nice to check whether you
> are getting a silent hang again, or perhaps something more verbose.
> 
> 	Ingo
> 

Doh! Sorry. Hard hang. Building -V0.6.9 already.

kr
