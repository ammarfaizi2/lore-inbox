Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268698AbUIXLoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268698AbUIXLoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268701AbUIXLoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:44:55 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:29415 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268698AbUIXLoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:44:19 -0400
Date: Fri, 24 Sep 2004 13:45:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm3-S5
Message-ID: <20040924114524.GA4467@elte.hu>
References: <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <415384E1.2080907@cybsft.com> <415394EE.50106@cybsft.com> <20040924074026.GB17368@elte.hu> <4153FF90.1010209@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4153FF90.1010209@cybsft.com>
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

> Maybe this wasn't the right way to fix the problem? I just looked at
> the S4 patch and it had the same change in it, but did not exhibit the
> same problem. Not knowing exactly what I was looking for, I just
> started looking for obvious changes that might affect dropping tcp
> connections and this one seemed reasonable. I made the change and the
> problem went away. Maybe this needs looking at a little closer.

S4 had other problems with softirq processing so i'd not be surprised if
that magically fixed the problem introduced by this change.

	Ingo
