Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUJOLrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUJOLrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 07:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUJOLrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 07:47:17 -0400
Received: from relay.pair.com ([209.68.1.20]:52238 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267679AbUJOLrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 07:47:03 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <416FB8B4.6080908@cybsft.com>
Date: Fri, 15 Oct 2004 06:47:00 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Daniel Walker <dwalker@mvista.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015022341.GA22831@nietzsche.lynx.com> <20041015070839.GA8373@elte.hu>
In-Reply-To: <20041015070839.GA8373@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Bill Huey <bhuey@lnxw.com> wrote:
> 
> 
>>On Fri, Oct 15, 2004 at 01:42:02AM +0200, Ingo Molnar wrote:
>>
>>>i have released the -U2 PREEMPT_REALTIME patch:
>>>
>>>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U2
>>
>>mm/shmem.c: In function `shmem_dir_map':
>>mm/shmem.c:103: warning: implicit declaration of function `kmap_atomic_rt'
>>mm/shmem.c:103: error: `KM_USER0' undeclared (first use in this function)
> 
> 
> as a workaround enable HIGHMEM and PREEMPT_TIMING+LATENCY_TRACE.
> 
> (i fixed this in my tree, will be in -U3.)
> 
> 	Ingo
> 
Sorry Bill. Is there a brown paper bag you can get that is not for 
writing the bug but misdiagnosing it? :)

kr
