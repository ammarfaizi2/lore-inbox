Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVEYNcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVEYNcD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVEYN36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:29:58 -0400
Received: from mail3.utc.com ([192.249.46.192]:7877 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262341AbVEYN2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:28:48 -0400
Message-ID: <42947D84.2000409@cybsft.com>
Date: Wed, 25 May 2005 08:28:36 -0500
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
References: <20050523082637.GA15696@elte.hu> <42935890.2010109@cybsft.com> <20050525113424.GA1867@elte.hu> <20050525113514.GA9145@elte.hu>
In-Reply-To: <20050525113514.GA9145@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>does it crash if you boot only with a single CPU (numcpus=1 boot 
>>parameter)? If yes then could you send me that log, some of the more 
>>interesting portions of the current log were garbled due to SMP 
>>logging effects.
> 
> 
> maxcpus=1 is the parameter.
> 
> 	Ingo
> 

No it doesn't crash if I boot only a single CPU. I'll go one better than 
that. It doesn't crash if I boot both CPUs but without hyper-threading 
(turned off in the bios but still enabled in the config). :-(

-- 
    kr
