Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270037AbUIDDoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270037AbUIDDoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270036AbUIDDoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:44:18 -0400
Received: from relay.pair.com ([209.68.1.20]:18960 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S270037AbUIDDnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:43:53 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <413939F8.1030806@cybsft.com>
Date: Fri, 03 Sep 2004 22:43:52 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R3
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com> <20040903181710.GA10217@elte.hu> <20040903193052.GA16617@elte.hu>
In-Reply-To: <20040903193052.GA16617@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>i'll add a new feature to debug this: when crashing on an assert and
>>tracing is enabled the trace leading up to the crash will be printed
>>to the console. [...]
> 
> 
> the -R3 patch has this feature:
> 

After hammering the system for a little more than an hour it gave up. I
don't have the serial logging setup yet because I haven't had time this
evening. I will be glad to do whatever I can to try to help debug this,
but it will have to wait until tomorrow. The log is here:

http://www.cybsft.com/testresults/crashes/2.6.9-rc1-vo-R3.txt

kr

Sorry I forgot to mention that this was triggered running the 
stress-kernel package, minus the NFS-Compile, but it does include the 
CRASHME test. In addition, amlat was running as well. The system was 
pretty much 100% loaded.
