Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWCXLaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWCXLaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWCXLaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:30:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:13992 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1422683AbWCXLaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:30:16 -0500
Date: Fri, 24 Mar 2006 12:27:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] get rid of unnecessary (un)likely's
Message-ID: <20060324112735.GA10246@elte.hu>
References: <1143145668.17529.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143145668.17529.32.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Thomas/Ingo
> 
> Looking at the code, I notice that there are a few likely and unlikely 
> flags that really don't belong.  Really there is two places, but for 
> the rt_mutex and rt_sems, they are the same.

looks good - applied.

	Ingo
