Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUHUOFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUHUOFA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 10:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUHUOFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 10:05:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30600 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266341AbUHUOE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 10:04:59 -0400
Date: Sat, 21 Aug 2004 16:05:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>
Subject: [patch] voluntary-preempt-2.6.8.1-P7
Message-ID: <20040821140501.GA4189@elte.hu>
References: <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820195540.GA31798@elte.hu>
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


i've uploaded the -P7 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P7

Changes since -P6:

- fixed the XFree86/X.org context-switch latency. (let me know if you
  see any weirdness like X not starting up while it did before.)

- halved the pagevec size, to reduce the radix gang-lookup costs.

	Ingo
