Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946512AbWJTVQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946512AbWJTVQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946523AbWJTVQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:16:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946512AbWJTVQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:16:28 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Peschke <mp3@de.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] statistics: fix buffer overflow in histogram with linear scale
References: <1161352724.3135.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	<20061020115242.ff4acce2.akpm@osdl.org>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 20 Oct 2006 17:15:20 -0400
In-Reply-To: <20061020115242.ff4acce2.akpm@osdl.org>
Message-ID: <y0mpscmvgd3.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> So...  what are we going to do with the statistics stuff?  It needs users
> to prove its desirability/suitability.  I think there was some work done in
> the SCSI area - did that come to anything?

There may be an opportunity here for combining this and the
markers-based lttng work.  Statistics gathering would be just one of
several possible back-end for events corresponding to scsi quantity
changes: tracing or more elaborate probing would also be enabled.

- FChE
