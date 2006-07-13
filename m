Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWGMHsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWGMHsP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWGMHsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:48:15 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:52452 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751260AbWGMHsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:48:14 -0400
Message-ID: <44B5F9E6.8070501@andrew.cmu.edu>
Date: Thu, 13 Jul 2006 03:44:38 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: andrea@cpushare.com
CC: Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, bunk@stusta.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, alan@redhat.com, torvalds@osdl.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
References: <20060630014050.GI19712@stusta.de>	<20060630045228.GA14677@opteron.random>	<20060630094753.GA14603@elte.hu>	<20060630145825.GA10667@opteron.random>	<20060711073625.GA4722@elte.hu>	<20060711141709.GE7192@opteron.random>	<1152628374.3128.66.camel@laptopd505.fenrus.org>	<20060711153117.GJ7192@opteron.random>	<1152635055.18028.32.camel@localhost.localdomain>	<p73wtain80h.fsf@verdi.suse.de>	<20060712210732.GA10182@elte.hu> <20060712185103.f41b51d2.akpm@osdl.org>
In-Reply-To: <20060712185103.f41b51d2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 12 Jul 2006 23:07:32 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
>> Despite good resons to apply the patch, it has not been applied yet, 
>> with no explanation.
> 
> I queued the below.  Andrea claims that it'll reduce seccomp overhead to
> literally zero.
> 
> But looking at it, I think it's a bit confused.  The patch needs
> s/DISABLE_TSC/ENABLE_TSC/ to make it right.
<-- snip -->

Andrea,
what happened to Andrew James Wade's rewording [1] of your config help? 
   It seemed to disappear from what was submitted to akpm.

To "mathematically prevent covert channels" is far too strong a claim to 
make, since you only handle the case of TSC-related timing attacks. 
AJW's wording is much better, so please don't drop it.

Of course, if the new wording will be included in some forthcoming patch 
that also makes Linus happy [2], then never mind.

  - Jim Bruce

[1] http://lkml.org/lkml/2006/7/10/440
[2] http://lkml.org/lkml/2006/7/12/328
