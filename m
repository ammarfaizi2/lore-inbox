Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269823AbUIDGtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269823AbUIDGtd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 02:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269818AbUIDGtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 02:49:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3044 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269823AbUIDGta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 02:49:30 -0400
Date: Sat, 4 Sep 2004 08:41:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R3
Message-ID: <20040904064121.GA31348@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com> <20040903181710.GA10217@elte.hu> <20040903193052.GA16617@elte.hu> <413939F8.1030806@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413939F8.1030806@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> http://www.cybsft.com/testresults/crashes/2.6.9-rc1-vo-R3.txt

the first line seems partial - isnt the full oops in the log?

> Sorry I forgot to mention that this was triggered running the
> stress-kernel package, minus the NFS-Compile, but it does include the
> CRASHME test. In addition, amlat was running as well. The system was
> pretty much 100% loaded.

Have you run crashme as root? That would be unsafe.

	Ingo
