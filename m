Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUIHN0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUIHN0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267774AbUIHNJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:09:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15756 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267568AbUIHNIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:08:41 -0400
Date: Wed, 8 Sep 2004 15:10:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908131015.GA21470@elte.hu>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908125755.GC3106@holomorphy.com> <20040908140146.A31601@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908140146.A31601@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> Personally I'm extremly unhappy with that week model for things like
> this.  There's no reason why architectures could implement irq
> handling as inlines.  Or in case of s390 not at all.

s390 is a special case i agree - no IRQ handling is a special case. We
can exclude kernel/hardirq.o on s390 and all virtual-guest platforms.

	Ingo
