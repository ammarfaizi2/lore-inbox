Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWF3Szk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWF3Szk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWF3Szk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:55:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52969 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751040AbWF3Szj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:55:39 -0400
Date: Fri, 30 Jun 2006 20:50:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Milan Svoboda <msvoboda@ra.rockwell.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Deepak Saxena <dsaxena@plexity.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
Message-ID: <20060630185046.GB29566@elte.hu>
References: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com> <Pine.LNX.4.64.0606291334540.10401@localhost.localdomain> <Pine.LNX.4.58.0606290803190.25935@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0606290803190.25935@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Well, the following patch may not be the best but I don't see it being 
> any worse than what is already there.  I don't have any arm platforms 
> or even an arm compiler, so I haven't even tested this patch with a 
> compile.  But it should be at least a temporary fix.

thanks - i've applied this to -rt, we'll drop it once we rebase to 
2.6.18-rc.

	Ingo
