Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUHPMMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUHPMMH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUHPMMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:12:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20417 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267565AbUHPMMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:12:03 -0400
Date: Mon, 16 Aug 2004 14:09:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: [patch] voluntary-preempt-2.6.8.1-P2
Message-ID: <20040816120933.GA4211@elte.hu>
References: <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net> <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816113131.GA30527@elte.hu>
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


here's -P2:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P2

Changes since -P1:

 - trace interrupted kernel code (via hardirqs, NMIs and pagefaults)

 - yet another shot at trying to fix the IO-APIC/USB issues.

 - mcount speedups - tracing should be faster

	Ingo
