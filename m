Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUIAXRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUIAXRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIAXOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:14:08 -0400
Received: from mail3.utc.com ([192.249.46.192]:32222 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S267851AbUIAUy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:54:29 -0400
Message-ID: <413636D0.5080603@cybsft.com>
Date: Wed, 01 Sep 2004 15:53:36 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Thomas Charbonnel <thomas@undata.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Mark_H_Johnson@raytheon.com,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
References: <200408282210.03568.pnambic@unu.nu>	 <20040828203116.GA29686@elte.hu>	 <1093727453.8611.71.camel@krustophenia.net>	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>	 <1093737080.1385.2.camel@krustophenia.net>	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>	 <20040830090608.GA25443@elte.hu> <20040901082958.GA22920@elte.hu>	 <20040901135122.GA18708@elte.hu>  <1094058546.6465.2.camel@localhost> <1094069473.7477.2.camel@twins>
In-Reply-To: <1094069473.7477.2.camel@twins>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Wed, 2004-09-01 at 19:09 +0200, Thomas Charbonnel wrote:
> 
>>Ingo Molnar wrote :
>>
>>>i've released the -Q7 patch:
>>>
>>>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q7
>>
>>With Q7 I still get rx latency issues (> 130 us non-preemptible section
>>from rtl8139_poll). Moreover network connections were extremely slow
>>(almost hung) until I set /proc/sys/net/core/netdev_backlog_granularity
>>to 2.
>>
>>Thomas
>>
> 
> 
> Me too!
> I too have a rtl8139 network card.
> 
> kr, what kind of nic do you have since this does not occur on your
> machine?
> 

Ethernet Pro 100.
