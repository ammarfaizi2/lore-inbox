Return-Path: <linux-kernel-owner+w=401wt.eu-S932781AbWLNUVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbWLNUVd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932864AbWLNUVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:21:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46280 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932880AbWLNUVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:21:31 -0500
Date: Thu, 14 Dec 2006 21:19:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] wrong config option in sched.c for notick
Message-ID: <20061214201906.GB32177@elte.hu>
References: <1166112093.1785.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166112093.1785.25.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> In compiling the kernel without high res, I hit this error:
> 
> kernel/sched.c:4135: error: notick undeclared (first use in this function)
> kernel/sched.c:4135: error: (Each undeclared identifier is reported only once
> kernel/sched.c:4135: error: for each function it appears in.)
> 
> I'm assuming that this was meant for NO_HZ.

yeah.

	Ingo
