Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUHaStl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUHaStl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUHaStl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:49:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34764 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266622AbUHaStj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:49:39 -0400
Date: Tue, 31 Aug 2004 20:50:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831185054.GC25485@elte.hu>
References: <OF923A124A.1D8E364E-ON86256F01.0053F7B2-86256F01.0053F7D7@raytheon.com> <1093972819.5403.8.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093972819.5403.8.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Hmm, looks like the es1371 takes ~0.5 ms to set the DAC rate.  The
> ALSA team would probably be able to help.  Takashi, any ideas?

i'd suggest to postpone this issue for the time being, the SMP hardware
in question produces 'mysterious' latencies in other, very unexpected
places as well. I suspect there's some issue that hits whatever code
happens to run - and the es1371 driver is used for the latency testing. 
So i believe it's just an innocent bystander. I'd suggest to look at
these again if they pop up after the 'mysterious' latency source is
found.

	Ingo
