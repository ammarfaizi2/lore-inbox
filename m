Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUJODUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUJODUI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 23:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUJODUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 23:20:08 -0400
Received: from relay.pair.com ([209.68.1.20]:43276 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S266009AbUJODUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 23:20:01 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <416F41DF.80901@cybsft.com>
Date: Thu, 14 Oct 2004 22:19:59 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Daniel Walker <dwalker@mvista.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015022341.GA22831@nietzsche.lynx.com> <416F388A.3060204@cybsft.com> <20041015024743.GA22893@nietzsche.lynx.com>
In-Reply-To: <20041015024743.GA22893@nietzsche.lynx.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Thu, Oct 14, 2004 at 09:40:10PM -0500, K.R. Foley wrote:
> 
>>>mm/shmem.c:1362: warning: assignment makes pointer from integer without a 
>>>cast
>>>mm/shmem.c: In function `shmem_symlink':
>>>mm/shmem.c:1719: error: `KM_USER0' undeclared (first use in this function)
>>>mm/shmem.c:1719: warning: assignment makes pointer from integer without a 
>>>cast
>>>make[1]: *** [mm/shmem.o] Error 1
>>>make: *** [mm] Error 2
>>>root@nietzsche> /home/bhuey/linux-2.6.8% 17# make tags
>>
>>What platform are you getting this on?
> 
> 
> x86

Not sure how you could be missing these with any configuration. Ah. Did 
you miss Linus' rc4 patch by any chance?

Just finished booting my slower UP box. My SMP box has been up for about 
1 hr 45 mins.

kr
> 
> I ran into other build problems BTW too.
> 
> bill
> 
> 

