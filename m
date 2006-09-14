Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWINTs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWINTs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWINTs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:48:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:900 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751104AbWINTs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:48:58 -0400
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
	<450971CB.6030601@mbligh.org>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 14 Sep 2006 15:48:17 -0400
In-Reply-To: <450971CB.6030601@mbligh.org>
Message-ID: <y0mmz92cjr2.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> writes:

> [...] What would be really nice is one trace infrastructure, that
> allowed both static and dynamic tracepoints

We in systemtap land hope to encounter *some* static tracepoint
structure, perhaps like the one I presented at OLS, via which
systemtap could become your unified static+dynamic "infrastructure".
Even in that universe, using LTT-derived code for high-performance
tracing is within the realm of reason.

> without all the awk-style language crap that seems to come with
> systemtap.

I'm sorry to hear you dislike the scripting language.  But that's
okay, you Real Men can embed literal C code inside systemtap scripts
to do the Real Work, and leave to systemtap only sundry duties such as
probe placement and removal.

- FChE
