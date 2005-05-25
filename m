Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVEYODn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVEYODn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 10:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVEYODm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 10:03:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48042 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262350AbVEYODj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 10:03:39 -0400
Date: Wed, 25 May 2005 16:03:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050525140316.GA29996@elte.hu>
References: <20050523082637.GA15696@elte.hu> <42935890.2010109@cybsft.com> <20050525113424.GA1867@elte.hu> <20050525113514.GA9145@elte.hu> <42947D84.2000409@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42947D84.2000409@cybsft.com>
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

> No it doesn't crash if I boot only a single CPU. I'll go one better 
> than that. It doesn't crash if I boot both CPUs but without 
> hyper-threading (turned off in the bios but still enabled in the 
> config). :-(

hm, must be some race. I tried it on a HT system too - will try on 
another HT system.

can you work it around (or turn it into another type of crash) by 
disabling STOP_MACHINE? (you can do that by turning off MODULE_UNLOAD)

	Ingo
