Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWINTk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWINTk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWINTk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:40:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29674 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751082AbWINTky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:40:54 -0400
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Ingo Molnar <mingo@elte.hu>, Karim Yaghmour <karim@opersys.com>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
	<Pine.LNX.4.64.0609141537120.6762@scrub.home>
	<20060914135548.GA24393@elte.hu> <20060914151905.GB29906@Krystal>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 14 Sep 2006 15:39:58 -0400
In-Reply-To: <20060914151905.GB29906@Krystal>
Message-ID: <y0mr6yeck4x.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> writes:

> [...]  However, I restate that my position is that both static and
> dynamic instrumentation of the kernel are a necessity and that a
> tracer core should be usable by both.

On a complementary note, it would be nice if whatever static
instrumetation hooks are deemed worthwhile were themselves generic so
they could be coupled to either a fixed or dynamic "core" or back-end.

- FChE
