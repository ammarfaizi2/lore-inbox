Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVEYLfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVEYLfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVEYLfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:35:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26297 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262202AbVEYLe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:34:58 -0400
Date: Wed, 25 May 2005 13:34:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050525113424.GA1867@elte.hu>
References: <20050523082637.GA15696@elte.hu> <42935890.2010109@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42935890.2010109@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> I did finally get to capture the log of -RT-2.6.12-rc4-V0.7.47-08 
> dying when booting. I have attached the log and the config. This is on 
> dual 2.6G Xeon with ht and smp enabled, 512M and IDE. What else can I 
> do (in between alligators)? Output from lspci:

hm, i have tried your .config on similar hardware and it doesnt crash.

does it crash if you boot only with a single CPU (numcpus=1 boot 
parameter)? If yes then could you send me that log, some of the more 
interesting portions of the current log were garbled due to SMP logging 
effects.

	Ingo
