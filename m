Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWFPPpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWFPPpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWFPPpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:45:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63669 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751417AbWFPPpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:45:09 -0400
To: eranian@hpl.hp.com
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com, wcohen@redhat.com,
       perfmon@napali.hpl.hp.com
Subject: Re: [PATCH 9/16] 2.6.17-rc6 perfmon2 patch for review: kernel-level API support (kapi)
References: <200606150907.k5F97coF008178@frankl.hpl.hp.com>
	<20060616135014.GB12657@infradead.org>
	<20060616140234.GI10034@frankl.hpl.hp.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 16 Jun 2006 11:41:32 -0400
In-Reply-To: <20060616140234.GI10034@frankl.hpl.hp.com>
Message-ID: <y0mhd2lumz7.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephane Eranian <eranian@hpl.hp.com> writes:

> > > This patch contains the kernel-level API support.
> > NACK.  No one should call this from kernel space.
>
> Well, that's what I initially thought too but there is a need from
> the SystemTap people and given the way they set things up, it is
> hard to do it from user level. [...]

Whether one uses systemtap, raw kprobes, or some specialized
tracing/stats-collecting patch surely forthcoming, kernel-level APIs
would be needed to perform fine-grained kernel-scope measurements
using these counters.

- FChE
