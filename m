Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266176AbUHWVHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUHWVHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267293AbUHWVDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:03:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4245 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266509AbUHWVAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:00:16 -0400
Date: Mon, 23 Aug 2004 23:01:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>
Subject: [patch] voluntary-preempt-2.6.8.1-P8
Message-ID: <20040823210151.GA10949@elte.hu>
References: <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821140501.GA4189@elte.hu>
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


i've uploaded the -P8 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P8

Changes since -P8:

 - fixes the DRI/DRM latency in radeon (and other drivers). The concept 
   was investigated/tested by Dave Airlie.

 - reduce netdev_max_backlog to 8 (Mark H Johnson)

	Ingo
