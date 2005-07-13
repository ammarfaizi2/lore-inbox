Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVGMOBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVGMOBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 10:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVGMOBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 10:01:23 -0400
Received: from relay00.pair.com ([209.68.1.20]:2573 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S262591AbVGMOBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 10:01:22 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42D51EAF.2070603@cybsft.com>
Date: Wed, 13 Jul 2005 09:01:19 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Chuck Harding <charding@llnl.gov>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050709155704.GA14535@elte.hu> <200507091704.12368.s0348365@sms.ed.ac.uk> <200507111455.45105.s0348365@sms.ed.ac.uk> <20050711141232.GA16586@elte.hu> <20050711141622.GA17327@elte.hu> <20050711150711.GA19290@elte.hu> <1121198946.10580.13.camel@mindpipe> <Pine.LNX.4.63.0507121331480.9097@ghostwheel.llnl.gov> <20050713103930.GA16776@elte.hu>
In-Reply-To: <20050713103930.GA16776@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Chuck Harding <charding@llnl.gov> wrote:
> 
> 
>>>CC [M]  sound/oss/emu10k1/midi.o
>>>sound/oss/emu10k1/midi.c:48: error: syntax error before '__attribute__'
>>>sound/oss/emu10k1/midi.c:48: error: syntax error before ')' token
>>>
>>>Here's the offending line:
>>>
>>>  48 static DEFINE_SPINLOCK(midi_spinlock __attribute((unused)));
>>>
>>>Lee
>>>
>>
>>I got it to compile but it won't boot - it hangs right after the
>>'Uncompressing Linux... OK, booting the kernel' - I'm using .config
>>from 51-27 (attached)
> 
> 
> and -51-27 worked just fine? I've uploaded -29 with the -28 io-apic 
> changes undone (will re-apply them once Karsten has figured out what's 
> wrong).
> 
> 	Ingo

I too had the same problem booting -51-28 on my older SMP system at 
home. -51-29 just booted fine.


-- 
    kr
