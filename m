Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269125AbUIHLnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269125AbUIHLnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269122AbUIHLnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:43:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44760 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269125AbUIHLnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:43:19 -0400
Date: Wed, 8 Sep 2004 13:44:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] preempt-smp.patch, 2.6.9-rc1-bk14
Message-ID: <20040908114446.GA14286@elte.hu>
References: <20040908111751.GA11507@elte.hu> <20040908124002.A30883@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908124002.A30883@infradead.org>
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

> > NOTE to architecture maintainers: generic_raw_read_trylock() is a crude
> > version that should be replaced with the proper arch-optimized version
> > ASAP.
> 
> I'd suggest not providing it at all then, because that forces arch
> maintainers to implement it. 

while generic it's actually correct for the purpose it's being used for
right now and all architectures should thus compile & work fine.

	Ingo
