Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWIZNig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWIZNig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWIZNig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:38:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38537 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751428AbWIZNif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:38:35 -0400
Date: Tue, 26 Sep 2006 15:30:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Jiri Kosina <jikos@jikos.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 2/2] serio: lockdep annotation for ps2dev->cmd_mutex and serio->lock
Message-ID: <20060926133043.GA30226@elte.hu>
References: <20060926113150.294656000@chello.nl> <20060926113748.833215000@chello.nl> <Pine.LNX.4.64.0609261520280.3938@twin.jikos.cz> <1159277799.5038.22.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159277799.5038.22.camel@lappy>
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


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> > Below is the fixed version of the patch. I confirm that this 
> > (together with Peter's original changes in lockdep, already acked by 
> > Ingo) fixes the synpatics passthrough port lockdep warnings.
> > 
> > So, as long as you, Dmitry, seem to be convenient with this 
> > approach, please apply. Thanks.
> > 
> > Signed-off-by: Jiri Kosina <jikos@jikos.cz>
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

great. Re-ack:

 Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
