Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269959AbUJND75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269959AbUJND75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 23:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269960AbUJND75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 23:59:57 -0400
Received: from relay.pair.com ([209.68.1.20]:36873 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269959AbUJND74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 23:59:56 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <416DF9BA.6010206@cybsft.com>
Date: Wed, 13 Oct 2004 22:59:54 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
In-Reply-To: <20041014002433.GA19399@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i'm pleased to announce a significantly improved version of the
> Real-Time Preemption (PREEMPT_REALTIME) feature that i have been working
> towards in the past couple of weeks.
> 
> the patch (against 2.6.9-rc4-mm1) can be downloaded from:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U0
> 

Don't try to debug spinlocks as in CONFIG_DEBUG_SPINLOCK and 
CONFIG_PREEMPT_REALTIME at the same time. The two are currently 
incompatible.

kr
