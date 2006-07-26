Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030450AbWGZIsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbWGZIsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWGZIsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:48:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:150 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030450AbWGZIsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:48:02 -0400
Date: Wed, 26 Jul 2006 10:41:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 0/3] [-rt] Fixes the timeout-bug in the rtmutex/PI-futex.
Message-ID: <20060726084152.GA15909@elte.hu>
References: <Pine.LNX.4.64.0607230215480.11861@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607230215480.11861@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <nielsen.esben@googlemail.com> wrote:

> -- Hi,
>  I finally got around to send in the a new version of my fixes to PI. 
>  The main purpose is to fix the timeout bug of the rtmutex/PI-futex. 

there's quite a bit of whitespace damage in your patchqueue. For example 
all the 'context' lines have an extra space at their beginning, which 
causes 'patch' to fail on every single chunk. There's also the 
occasional '8 spaces instead of a tab' buglet, probably introduced while 
writing this code.

	Ingo
