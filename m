Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUHTOie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUHTOie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUHTOie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:38:34 -0400
Received: from mail3.utc.com ([192.249.46.192]:56793 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S268115AbUHTOia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:38:30 -0400
Message-ID: <41260CA6.2040306@cybsft.com>
Date: Fri, 20 Aug 2004 09:37:26 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P5
References: <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
In-Reply-To: <20040820133031.GA13105@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
 > i've uploaded the -P5 patch:
 >
 >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P5
 >
<snip>

I have been running the voluntary-preempt patches on one of my slower
(450) servers at home. The question is would latency traces from such a
slow system be useful to you in this testing. About the most load that
gets generated on this system, usually, is compiling the kernel or a
very large app. that I do development on. What I tend to do to load the
system is just run the stress-kernel suite and sometimes Andrew's amlat
program to provide RT scheduling pressure.

If this would be useful, let me know as I have an interest in seeing
latencies reduced as much as possible. I am building with the -P5 patch
right now. If it would be more useful to try this on a faster system or
to stess the system in a different manner, I could do that as well.

kr
