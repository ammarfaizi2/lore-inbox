Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269583AbUICRNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbUICRNb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269486AbUICRLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:11:42 -0400
Received: from mail4.utc.com ([192.249.46.193]:6307 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S269583AbUICRLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:11:02 -0400
Message-ID: <4138A56B.4050006@cybsft.com>
Date: Fri, 03 Sep 2004 12:10:03 -0500
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
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu>
In-Reply-To: <20040902215728.GA28571@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -R0 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R0
>  
> ontop of:
> 
>   http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
> 

Managed to hang the system again under heavy load. This time with the 
above patch:

http://www.cybsft.com/testresults/crashes/2.6.9-rc1-bk4-R0.txt

Last time was with Q7:

http://www.cybsft.com/testresults/crashes/2.6.9-rc1-bk4-Q7.txt


kr

