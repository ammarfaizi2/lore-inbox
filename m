Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUHTKjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUHTKjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUHTKjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:39:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64917 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266034AbUHTKjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:39:36 -0400
Date: Fri, 20 Aug 2004 12:41:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
Message-ID: <20040820104107.GA20446@elte.hu>
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <1092972918.10063.11.camel@krustophenia.net> <20040820081319.GA4321@elte.hu> <1092993242.10063.66.camel@krustophenia.net> <20040820102732.GA14622@elte.hu> <1092998028.10063.103.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092998028.10063.103.camel@krustophenia.net>
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

> > well, 9 msecs is still not nice. I've been able to trigger larger than
> > 10msec latencies too on a 2 GHz box.
> 
> If this is the case then should a make -j12 have ground the machine to
> a halt the way it did?

well, does it slow down that much with tracing and voluntary-preempt 
disabled too?

	Ingo
