Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267480AbUIBF6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267480AbUIBF6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUIBF6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:58:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28130 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267480AbUIBF6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:58:11 -0400
Date: Thu, 2 Sep 2004 07:40:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Mark_H_Johnson@raytheon.com,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
Message-ID: <20040902054008.GA12755@elte.hu>
References: <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu> <20040901082958.GA22920@elte.hu> <20040901135122.GA18708@elte.hu> <41367E5D.3040605@cybsft.com> <20040902053719.GA12684@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902053719.GA12684@elte.hu>
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

> > 00000001 0.000ms (+0.000ms): n_tty_receive_buf (pty_write)
> > 00010001 3.992ms (+3.992ms): do_IRQ (n_tty_receive_buf)
> 
> the overhead is always relative to the previous entry [...]

i've changed the /proc/latency_trace output in my tree to print the
latency of this entry relative to the next entry, not the previous
entry. This should be more intuitive than using the previous entry.

	Ingo
