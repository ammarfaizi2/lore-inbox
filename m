Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUHXRof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUHXRof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 13:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUHXRof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 13:44:35 -0400
Received: from mail3.utc.com ([192.249.46.192]:17285 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S267176AbUHXRoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 13:44:13 -0400
Message-ID: <412B7E50.1030806@cybsft.com>
Date: Tue, 24 Aug 2004 12:43:44 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu>
In-Reply-To: <20040824061459.GA29630@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Scott Wood <scott@timesys.com> wrote:
> 
> 
>>I have attached a port of the voluntary preempt patch to PPC and
>>PPC64.  The patch is against P7, but it applies against P8 as well.
> 
> 
> thanks Scott, i've applied your patch to my tree - all the changes and
> improvements look good (except for a small compilation problem on x86,
> asm/time.h doesnt exist there - asm/rtc.h does). The resulting code
> booted fine on an SMP and on a UP x86 system. I've uploaded -P9:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
> 
> (there are no other changes in -P9.)
> 
> 	Ingo
> -

~254 usec latency seen in kswapd:

http://www.cybsft.com/testresults/2.6.8.1-P9/latency_trace2.txt



