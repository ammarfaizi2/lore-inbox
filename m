Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVEYPWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVEYPWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVEYPUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:20:52 -0400
Received: from mail3.utc.com ([192.249.46.192]:45448 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262373AbVEYPUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:20:36 -0400
Message-ID: <429497B8.2070200@cybsft.com>
Date: Wed, 25 May 2005 10:20:24 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <20050523082637.GA15696@elte.hu> <42935890.2010109@cybsft.com> <20050525113424.GA1867@elte.hu> <20050525113514.GA9145@elte.hu> <42947D84.2000409@cybsft.com> <20050525140316.GA29996@elte.hu>
In-Reply-To: <20050525140316.GA29996@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>No it doesn't crash if I boot only a single CPU. I'll go one better 
>>than that. It doesn't crash if I boot both CPUs but without 
>>hyper-threading (turned off in the bios but still enabled in the 
>>config). :-(
> 
> 
> hm, must be some race. I tried it on a HT system too - will try on 
> another HT system.
> 
> can you work it around (or turn it into another type of crash) by 
> disabling STOP_MACHINE? (you can do that by turning off MODULE_UNLOAD)
> 
> 	Ingo
> 

OK. Unfortunately with MODULE_UNLOAD not set, I can't seem to make it 
crash. :-/

-- 
    kr
