Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266197AbUGJIuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbUGJIuL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUGJIuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:50:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61368 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266197AbUGJIuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:50:07 -0400
Date: Sat, 10 Jul 2004 10:50:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Redeeman <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710085044.GA14262@elte.hu>
References: <20040709182638.GA11310@elte.hu> <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710080234.GA25155@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> * Redeeman <lkml@metanurb.dk> wrote:
> 
> > this all seems pretty cool... do you think you could make a patch
> > against mm for this? it would be greatly apreciated
> 
> it should apply cleanly to 2.6.7-mm6. -mm7 already includes most of the
> might_sleep() additions. I'll do a patch against -mm7 too.

here's the patch against -mm7:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.7-mm7-H3

the patch got really small because most of the fixes and infrastructure
enhancements that resulted out of this patch are in -mm7 already. It
will get even smaller later on.

	Ingo
