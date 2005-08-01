Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVHAVEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVHAVEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVHAVDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:03:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39076 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261255AbVHAVCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:02:41 -0400
Date: Mon, 1 Aug 2005 23:03:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Luca Falavigna <dktrkranz@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Real-Time Preemption V0.7.52-07: rt_init_MUTEX_LOCKED declaration
Message-ID: <20050801210324.GA21087@elte.hu>
References: <42EE4D27.8060500@gmail.com> <1122922658.6759.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122922658.6759.22.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> -	struct semaphore stop;
> +	struct compat_semaphore stop;

i think it's policy->lock that is the issue here?

	Ingo
