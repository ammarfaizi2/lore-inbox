Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUIBIWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUIBIWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 04:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267859AbUIBIWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 04:22:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45961 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267799AbUIBIWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 04:22:10 -0400
Date: Thu, 2 Sep 2004 10:23:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       alsa-devel@lists.sourceforge.net
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Message-ID: <20040902082324.GA27031@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902065549.GA18860@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> this release fixes an artificial 0-1msec delay between hardirq arrival
> and softirq invocation. This should solve some of the ALSA artifacts
> reported by Mark H Johnson. It should also solve the rtl8139 problems
> - i've put such a card into a testbox and with -Q7 i had similar
> packet latency problems while with -Q8 it works just fine.

the rtl8139 problems are not fixed yet - i can still reproduce the
delayed packet issues.

	Ingo
