Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWGZIRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWGZIRO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWGZIRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:17:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4224 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932522AbWGZIRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:17:13 -0400
Date: Wed, 26 Jul 2006 10:10:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>,
       "Duetsch, Thomas LDE1" <thomas.duetsch@siemens.com>
Subject: Re: [PATCH -rt] Don't let raise_softirq_prio lower the prio (was: [RT] rt priority losing)
Message-ID: <20060726081039.GA11604@elte.hu>
References: <1153755660.4002.137.camel@localhost.localdomain> <Pine.LNX.4.64.0607241758420.10471@localhost.localdomain> <1153759042.11295.10.camel@localhost.localdomain> <Pine.LNX.4.64.0607241854360.10471@localhost.localdomain> <1153761301.11295.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153761301.11295.30.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I guess the simple fix is not to allow the interrupt to lower the 
> priority. But simple fixes do not always handle all the cases.
> 
> Thomas G., see any side effects with this patch?
> 
> -- Steve
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

thanks, applied. Thomas, fine with you too?

	Ingo
