Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVGMTpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVGMTpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVGMTno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:43:44 -0400
Received: from smtp-3.llnl.gov ([128.115.41.83]:47081 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S262455AbVGMTl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:41:59 -0400
Date: Wed, 13 Jul 2005 12:41:52 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
In-reply-to: <42D51EAF.2070603@cybsft.com>
To: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, karsten wiese <annabellesgarden@yahoo.de>
Message-id: <Pine.LNX.4.63.0507131228280.6886@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
 <20050709155704.GA14535@elte.hu> <200507091704.12368.s0348365@sms.ed.ac.uk>
 <200507111455.45105.s0348365@sms.ed.ac.uk> <20050711141232.GA16586@elte.hu>
 <20050711141622.GA17327@elte.hu> <20050711150711.GA19290@elte.hu>
 <1121198946.10580.13.camel@mindpipe>
 <Pine.LNX.4.63.0507121331480.9097@ghostwheel.llnl.gov>
 <20050713103930.GA16776@elte.hu> <42D51EAF.2070603@cybsft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005, K.R. Foley wrote:

> Ingo Molnar wrote:
>> * Chuck Harding <charding@llnl.gov> wrote:
>> 
>> 
>>>> CC [M]  sound/oss/emu10k1/midi.o
>>>> sound/oss/emu10k1/midi.c:48: error: syntax error before '__attribute__'
>>>> sound/oss/emu10k1/midi.c:48: error: syntax error before ')' token
>>>> 
>>>> Here's the offending line:
>>>>
>>>>  48 static DEFINE_SPINLOCK(midi_spinlock __attribute((unused)));
>>>> 
>>>> Lee
>>>> 
>>> 
>>> I got it to compile but it won't boot - it hangs right after the
>>> 'Uncompressing Linux... OK, booting the kernel' - I'm using .config
>>> from 51-27 (attached)
>> 
>> 
>> and -51-27 worked just fine? I've uploaded -29 with the -28 io-apic changes 
>> undone (will re-apply them once Karsten has figured out what's wrong).
>>
>> 	Ingo
>
> I too had the same problem booting -51-28 on my older SMP system at home. 
> -51-29 just booted fine.
>

I missed getting -51-29 but just booted up -51-30 and all is well. Thanks.
Just out of curiosity, what was changed between -51-28, 29, and 30?

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- I'm leaving my body to science fiction. --
