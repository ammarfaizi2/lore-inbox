Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbUJ0WRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbUJ0WRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbUJ0WNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:13:10 -0400
Received: from mail3.utc.com ([192.249.46.192]:45189 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262930AbUJ0Vlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:41:55 -0400
Message-ID: <418015D8.1010304@cybsft.com>
Date: Wed, 27 Oct 2004 16:40:40 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com>	 <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com>	 <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com>	 <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com>	 <20041027150548.GA11233@elte.hu>	 <1098889994.1448.14.camel@krustophenia.net>	 <20041027151701.GA11736@elte.hu> <1098897241.8596.5.camel@krustophenia.net>	 <417FD915.304@cybsft.com> <1098898017.8596.9.camel@krustophenia.net>	 <417FDE34.6020704@cybsft.com> <1098906454.1514.1.camel@krustophenia.net>
In-Reply-To: <1098906454.1514.1.camel@krustophenia.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2004-10-27 at 12:43 -0500, K.R. Foley wrote:
> 
>>OH! And thanks. :)
>>
> 
> 
> Well I tried it and it does not seem to work exactly right.  This might
> be because I enabled the HPET so the RTC is not getting used.  When I
> run amlat for a few minutes I get a histogram with only 38 samples.
> Does this work for you?
> 
> Lee
> 
> 
Sorry it took a while to get back to you. Yes I did try it a little 
earlier and did seem to be getting reasonable numbers. I wouldn't want 
to publish those numbers yet because I haven't done anything with 
priorities and I was seeing some higher numbers. I don't have the HPET 
turned on myself.

kr
