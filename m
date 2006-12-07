Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032097AbWLGMPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032097AbWLGMPR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032099AbWLGMPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:15:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40878 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032105AbWLGMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:15:13 -0500
Date: Thu, 7 Dec 2006 13:13:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>, Clark Williams <williams@redhat.com>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Giandomenico De Tullio <ghisha@email.it>
Subject: Re: v2.6.19-rt6, yum/rpm
Message-ID: <20061207121344.GA19749@elte.hu>
References: <20061205171114.GA25926@elte.hu> <4577FC21.1080407@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4577FC21.1080407@cybsft.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> > i have released the 2.6.19-rt6 tree, which can be downloaded from the 
> > usual place:
> 
> Attached patch fixes rtc histogram. Looks like it got broken around 
> 2.6.18-rt?, probably during the merge for 2.6.18?

thanks, applied. I have undone some rtc hacks in the 2.6.18 merge, i 
guess this collateral damage of that.

	Ingo
