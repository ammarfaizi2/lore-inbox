Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264170AbUFBVHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUFBVHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUFBVHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:07:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11411 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264170AbUFBVGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:06:48 -0400
Date: Wed, 2 Jun 2004 23:07:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040602210751.GA22389@elte.hu>
References: <20040602205025.GA21555@elte.hu> <20040602210008.GA8176@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602210008.GA8176@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> the _GPL export of vmalloc_exec is silly, it's a trivial __vmalloc
> wrapper and __vmalloc is exported.  You might be better of just
> killing it anyway, I don't see much use for it outside module support.

ok, agreed.

> apropos modules, in SuSE's 2.4 kernels Andi had a nice optimization to
> not use vmalloc if we could get high enough order allocations, might
> be worth ressurecting that.

yeah, this might make sense.

	Ingo
