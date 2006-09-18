Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWIRES0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWIRES0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 00:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWIRES0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 00:18:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:13546 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751549AbWIRESZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 00:18:25 -0400
Date: Mon, 18 Sep 2006 06:09:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Nicholas Miell <nmiell@comcast.net>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918040947.GA21191@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com> <20060918033027.GB11894@elte.hu> <450E1D2E.3080705@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450E1D2E.3080705@opersys.com>
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

> Ingo Molnar wrote:
> > Amazing! So the trace data provided by those removed static markups 
> > (which were moved into dynamic scripts and are thus still fully 
> > available to dynamic tracers) are still available to LTT users? How is 
> > that possible, via quantum tunneling perhaps? ;-)

> Previously alluded to script can easily be made to read mainlined 
> dynamic scripts and generate alternate build files for the designate 
> source. Let me know if I need to expand on this.

That suggestion is so funny to me that i'll let it stand here in its 
absurdity :) Did i get it right, you are suggesting for LTT to build a 
full SystemTap interpreter, an script-to-C compiler, an embedded-C 
script interpreter, just to be able to build-time generate the SystemTap 
scripts back into the source code? Dont you realize that you've just 
invented SystemTap, sans the ability to remove inactive code? ;)

I know a much easier method: a "static tracer" can do all of that (and 
more), if you rename "SystemTap" to "static tracer" ;-)

	Ingo
