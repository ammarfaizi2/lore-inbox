Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUHXGJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUHXGJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUHXGJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:09:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6368 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266311AbUHXGIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:08:16 -0400
Date: Tue, 24 Aug 2004 08:09:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
Message-ID: <20040824060946.GA31052@elte.hu>
References: <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu> <20040823210151.GA10949@elte.hu> <1093312154.862.17.camel@krustophenia.net> <412ABC8B.5080608@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412ABC8B.5080608@cybsft.com>
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

> http://www.cybsft.com/testresults/2.6.8.1-P8/latency_trace3.txt

this trace shows a TX processing latency of 45 frames - please try
'ifconfig eth0 txqueuelen 8', does it help?

	Ingo
