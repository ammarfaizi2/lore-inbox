Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267957AbUIUSY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267957AbUIUSY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUIUSY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:24:58 -0400
Received: from mail4.utc.com ([192.249.46.193]:54714 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S267957AbUIUSY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:24:56 -0400
Message-ID: <415071D4.9060601@cybsft.com>
Date: Tue, 21 Sep 2004 13:24:20 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
References: <20040906110626.GA32320@elte.hu> <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
In-Reply-To: <20040919122618.GA24982@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -S1 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S1
> 

Two separate oopses this morning running that above patch. One appears 
to happen in locks_delete_lock. The log output follows. Unfortunately I 
am not sure what is relevant to the oops and whats not so I am sending 
it all. Also the trace that was generated when this happened can be 
found here:

http://www.cybsft.com/testresults/2.6.9-rc2-mm1-VP-S0/lat_trace22.txt

log output:

http://www.cybsft.com/testresults/2.6.9-rc2-mm1-VP-S0/dump1.txt

The other appears to happen in __posix_lock_file.

Trace here:

http://www.cybsft.com/testresults/2.6.9-rc2-mm1-VP-S0/lat_trace23.txt

log output here:

http://www.cybsft.com/testresults/2.6.9-rc2-mm1-VP-S0/dump2.txt

If there is anything else that I can provide on these, or if there is a 
better way to post this, please let me know.

kr
