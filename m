Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267440AbUIUCZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267440AbUIUCZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 22:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUIUCZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 22:25:27 -0400
Received: from relay.pair.com ([209.68.1.20]:25866 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267440AbUIUCZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 22:25:26 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <414F9113.50509@cybsft.com>
Date: Mon, 20 Sep 2004 21:25:23 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
References: <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F1010.2060504@cybsft.com> <20040920194826.GA6356@elte.hu>
In-Reply-To: <20040920194826.GA6356@elte.hu>
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
>>Is anyone else having trouble getting this to build on x86 smp? I am
>>getting undefined references to smp_processor_id within most, if not
>>all, modules.
> 
> 
> add EXPORT_SYMBOL(smp_processor_id) to the end of sched.c.
> 
> 	Ingo
> 

Thanks. That did the trick along with the afs patch Andrew posted.

kr
