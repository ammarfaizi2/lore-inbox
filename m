Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWISPWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWISPWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWISPWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:22:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37823 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750806AbWISPWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:22:54 -0400
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Ingo Molnar <mingo@elte.hu>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 19 Sep 2006 11:21:43 -0400
In-Reply-To: <20060918234502.GA197@Krystal>
Message-ID: <y0md59revaw.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> writes:

> [...]  I take for agreed that both static and dynamic tracing are
> useful for different needs and that a full markup must support both
> and combinations, letting the user or the distribution choose.

Elaborating on Ingo's "one mechanism" comments, I believe a marker
widget needs to be generic at run time.  We're not just looking for a
way of hiding direct calls to lttng in a marker macro.  We're looking
for a way of marking spots & data in a uniform way, then later
(run-time) binding each of those markers to (tools such as) lttng
and/or systemtap.

- FChE
