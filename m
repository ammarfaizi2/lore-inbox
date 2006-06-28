Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423217AbWF1ISo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423217AbWF1ISo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423218AbWF1ISo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:18:44 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:57275 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423217AbWF1ISn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:18:43 -0400
Date: Wed, 28 Jun 2006 10:13:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: 2.6.17-mm3: arm: *_irq_wake compile error
Message-ID: <20060628081345.GA12647@elte.hu>
References: <20060627015211.ce480da6.akpm@osdl.org> <20060627224038.GF13915@stusta.de> <1151478544.25491.485.camel@localhost.localdomain> <20060628001208.2b034afd.akpm@osdl.org> <1151479204.25491.491.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151479204.25491.491.camel@localhost.localdomain>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 2006-06-28 at 00:12 -0700, Andrew Morton wrote:
> > OK, so I moved the above lines inside #ifdef CONFIG_GENERIC_HARDIRQS (diff
> > did a strange-looking thing with it):
> 
> Yeah, but its nevertheless correct. :)

lets hope it builds sparc64 & co too.

/me goes to try

	Ingo
