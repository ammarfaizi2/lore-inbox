Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTJRRK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTJRRK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:10:28 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:30436 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261723AbTJRRK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:10:26 -0400
Message-ID: <3F9173FE.5080308@softhome.net>
Date: Sat, 18 Oct 2003 19:10:22 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add a config option for -Os compilation
References: <H2MN.3cm.7@gated-at.bofh.it> <H366.3IC.9@gated-at.bofh.it> <H3fO.3VO.13@gated-at.bofh.it> <H3IO.4yt.9@gated-at.bofh.it> <HWvz.5PI.9@gated-at.bofh.it> <I1EP.5QO.1@gated-at.bofh.it>
In-Reply-To: <I1EP.5QO.1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> If you have a puny 128K L2 cache, it might help,

   [ I accept this as a flame-bait. ]
   Can you be little bit less ignorant? Eh?
   Please. I beg you.
   Linux is used not only by you, and not only on huge NUMA boxes with 
huge caches <flame-bait>to hide stupid design flaws</flame-bait>. (can't 
wait when clusters of hand-helds connected over bluetooth will wipe out 
mainframe market :)))

   My system has 16K L1 cache. Only L1. And what should I do?
   I was benchmarking 2.4.1[68] some time ago and -Os helps gcc to 
produce faster code (both gcc 2.95.3 and 3.2.3). (It was Geode. But e.g. 
Motorolla's PowerQuicc has 16K L1 too - but I'm not sure does -Os help 
on ppc)

   On my test difference was around 5-7%. Task was very IO intensive 
with few of computational branches. Size of .text ~ 800K, .bss ~ 400K.

> Please don't - I benchmarked it a while ago, and it's definitely slower.
> If you have a puny 128K L2 cache, it might help, but it definitely needs
> to be optional.

   Optional - would be Okay.

P.S. That's dependency on GCC what should be optional. Let's not forget 
the source of the problem.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

