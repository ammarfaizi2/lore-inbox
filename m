Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269291AbUIBX1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbUIBX1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269163AbUIBX1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:27:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14993 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269291AbUIBX1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:27:05 -0400
Date: Fri, 3 Sep 2004 01:28:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Message-ID: <20040902232839.GA32440@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <1094108653.11364.26.camel@krustophenia.net> <20040902071525.GA19925@elte.hu> <1094167534.1571.10.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094167534.1571.10.camel@krustophenia.net>
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

> Do you see any optional networking features in the trace (other than
> ip_conntrack)?  I was under the impression that I had everything
> optional disabled.

yeah, it seems to be only ip_conntrack and netfilter (which conntrack
relies on).

	Ingo
