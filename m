Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946514AbWJTVIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946514AbWJTVIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423232AbWJTVIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:08:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59858 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946512AbWJTVIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:08:43 -0400
Date: Fri, 20 Oct 2006 23:08:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Clark Williams <williams@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: time warp on 2.6.18-rt6 (2nd try)
Message-ID: <20061020210821.GA28420@elte.hu>
References: <4539158C.2090801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4539158C.2090801@redhat.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Clark Williams <williams@redhat.com> wrote:

> I'm still seeing the time warp ("It's just a jump to the left!" :))* 
> being triggered on both my Athlon64x2 (32-bit kernel) and my Athlon64 
> up box (64-bit kernel). [...]

that was most likely a false positive - every time settimeofday is done. 
I've just uploaded -rt7, could you check it whether the time warp 
messages are gone?

	Ingo
