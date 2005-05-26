Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVEZPX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVEZPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 11:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVEZPX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 11:23:56 -0400
Received: from mail3.utc.com ([192.249.46.192]:42709 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261569AbVEZPXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 11:23:46 -0400
Message-ID: <4295E9F7.1020005@cybsft.com>
Date: Thu, 26 May 2005 10:23:35 -0500
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
References: <20050523082637.GA15696@elte.hu> <42935890.2010109@cybsft.com> <20050525113424.GA1867@elte.hu> <20050525113514.GA9145@elte.hu> <42947D84.2000409@cybsft.com> <20050525140316.GA29996@elte.hu> <20050526074547.GA6057@elte.hu>
In-Reply-To: <20050526074547.GA6057@elte.hu>
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
>>>No it doesn't crash if I boot only a single CPU. I'll go one better 
>>>than that. It doesn't crash if I boot both CPUs but without 
>>>hyper-threading (turned off in the bios but still enabled in the 
>>>config). :-(
>>
>>hm, must be some race. I tried it on a HT system too - will try on 
>>another HT system.
> 
> 
> cannot reproduce it on my other HT system either. Do you see the same 
> crash with the latest, -rc5 based release too? Maybe we'll get a better 
> crashlog under that kernel.
> 
> 	Ingo
> 

This one seems to be fine, or at least it has gotten harder produce the 
problem. ;-) It is running fine on both of my dual systems currently and 
should know soon on one of the uni's.

-- 
    kr
