Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269750AbUICSuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269750AbUICSuD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269743AbUICSqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:46:54 -0400
Received: from mail4.utc.com ([192.249.46.193]:39404 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S269738AbUICSnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:43:00 -0400
Message-ID: <4138BAF5.3060105@cybsft.com>
Date: Fri, 03 Sep 2004 13:41:57 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com> <20040903183947.GA11417@elte.hu>
In-Reply-To: <20040903183947.GA11417@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Managed to hang the system again under heavy load. This time with the 
>>above patch:
>>
>>http://www.cybsft.com/testresults/crashes/2.6.9-rc1-bk4-R0.txt
> 
> 
> do you have CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP
> enabled? These are pretty good at e.g. catching illegal scheduling in
> critical sections much earlier. You can enable them on !SMP kernels as
> well.
> 
> 	Ingo

Not currently but I am enabling now.

kr
