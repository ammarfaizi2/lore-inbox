Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUIFGaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUIFGaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 02:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUIFGaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 02:30:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34447 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266813AbUIFGaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 02:30:10 -0400
Date: Mon, 6 Sep 2004 08:30:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
Message-ID: <20040906063040.GA11541@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <1094408203.4445.5.camel@krustophenia.net> <20040905191227.GA29797@elte.hu> <1094418192.4445.58.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094418192.4445.58.camel@krustophenia.net>
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

> http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-R0#/var/www/2.6.9-rc1-R0/foo.hist
> 
> I find the two smaller spikes to either side of the central spike
> really odd.  These showed up in my jackd tests too, I had attributed
> them to some measurement artifact, but they seem real.  Maybe a
> rounding bug, or some kind of weird cache effect?

interesting - the histograms are pretty symmetric around the center.
E.g. the exponential foo.hist2 diagram is way too symmetric around 50
usecs! What precisely is being measured?

	Ingo
