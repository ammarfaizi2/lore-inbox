Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUITTqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUITTqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUITTqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:46:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52181 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267234AbUITTqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:46:42 -0400
Date: Mon, 20 Sep 2004 21:48:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Message-ID: <20040920194826.GA6356@elte.hu>
References: <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F1010.2060504@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414F1010.2060504@cybsft.com>
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

> Is anyone else having trouble getting this to build on x86 smp? I am
> getting undefined references to smp_processor_id within most, if not
> all, modules.

add EXPORT_SYMBOL(smp_processor_id) to the end of sched.c.

	Ingo
