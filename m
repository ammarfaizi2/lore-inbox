Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUIVRl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUIVRl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUIVRlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:41:25 -0400
Received: from mail3.utc.com ([192.249.46.192]:54943 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S266003AbUIVRlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:41:20 -0400
Message-ID: <4151B91A.5040206@cybsft.com>
Date: Wed, 22 Sep 2004 12:40:42 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S3
References: <20040907092659.GA17677@elte.hu>	 <20040907115722.GA10373@elte.hu>	 <1094597988.16954.212.camel@krustophenia.net>	 <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net>	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>	 <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>	 <41519539.4010407@cybsft.com> <1095873391.498.41.camel@krustophenia.net>
In-Reply-To: <1095873391.498.41.camel@krustophenia.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2004-09-22 at 11:07, K.R. Foley wrote:
> 
>>Ingo Molnar wrote:
>>
>>>i've released the -S3 VP patch:
>>>
>>>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S3
>>>
>>
>>In order to get this to build I had to add
>>
>>#include <asm/delay.h>
>>
>>to linux/kernel/time.c
>>
> 
> 
> Builds fine for me, this must specific to your config, or Ingo fixed the
> patch.
> 
> Lee
> 
> 

Hmm. That seems odd.

By the way, should I have included linux/delay.h, which includes 
asm/delay.h instead of including it directly?

kr
