Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbUJ0Vt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbUJ0Vt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUJ0VtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:49:00 -0400
Received: from mail3.utc.com ([192.249.46.192]:43398 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262944AbUJ0VoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:44:04 -0400
Message-ID: <41801693.6010202@cybsft.com>
Date: Wed, 27 Oct 2004 16:43:47 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, rncbc@rncbc.org,
       Mark_H_Johnson@Raytheon.com, bhuey@lnxw.com, doogie@debian.org,
       mista.tapas@gmx.net, tglx@linutronix.de, xschmi00@stud.feec.vutbr.cz,
       nando@ccrma.Stanford.EDU
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041025104023.GA1960@elte.hu>	<417D4B5E.4010509@cybsft.com>	<20041025203807.GB27865@elte.hu>	<417E2CB7.4090608@cybsft.com>	<20041027002455.GC31852@elte.hu>	<417F16BB.3030300@cybsft.com>	<20041027132926.GA7171@elte.hu>	<417FB7F0.4070300@cybsft.com>	<20041027150548.GA11233@elte.hu>	<1098889994.1448.14.camel@krustophenia.net>	<20041027151701.GA11736@elte.hu> <20041027130919.1a1175f5.akpm@osdl.org>
In-Reply-To: <20041027130919.1a1175f5.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> 
>>>Here is a more up to date version of the rtc-debug patch:
>>
>> > 
>> > http://lkml.org/lkml/2004/9/9/307
>> > 
>> > There is still a bit of 2.4 cruft in there but it works well.  Maybe
>> > this could be included in future patches.
>>
>> the most natural point of inclusion would be Andrew's -mm tree i think
>> :-)
> 
> 
> It's 'orrid.  And iirc it breaks normal use of the RTC.
> 
It definitely changes the output of /dev/rtc if anything uses that.

kr
