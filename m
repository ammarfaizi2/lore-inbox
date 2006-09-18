Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965349AbWIRDGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965349AbWIRDGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 23:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965345AbWIRDGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 23:06:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46008 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965344AbWIRDGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 23:06:24 -0400
Date: Mon, 18 Sep 2006 04:57:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918025722.GA11894@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <450E053B.1070908@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450E053B.1070908@opersys.com>
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

* Karim Yaghmour <karim@opersys.com> wrote:

> >        MARK(event, a);
> ...
> > 	MARK(event, a, x);
> 
> You assume these are mutually exclusive. [...]

Plese dont put words into my mouth. No, i dont assume they are mutually 
exclusive, did i ever claim that? But i very much still claim what my 
point was, and which point you disputed (at the same time also insulting 
me): that even if hell freezes over, a static tracer wont be able to 
extract 'x' from the MARK(event, a) markup. You accused me unfairly, you 
insulted me and i defended my point. In case you forgot, here again is 
the incident, in its entirety, where i make this point and you falsely 
dispute it:

> > There can be differences though to 'static tracepoints used by 
> > static tracers': for example there's no need to 'mark' a static 
> > variable, because dynamic tracers have access to it - while a static 
> > tracer would have to pass it into its trace-event function call.
>
> That has been your own personal experience of such things. Fortunately 
> by now you've provided to casual readers ample proof that such 
> experience is but limited and therefore misleading. The fact of the 
> matter is that *mechanisms* do not "magically" know what detail is 
> necessary for a given event or how to interpret it: only *markup* does 
> that.

	Ingo
