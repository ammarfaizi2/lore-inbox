Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVGZMGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVGZMGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 08:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVGZMGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 08:06:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28547 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261720AbVGZMGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 08:06:44 -0400
Date: Tue, 26 Jul 2005 14:06:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Andreas Steinmetz <ast@domdv.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.13rc3: RLIMIT_RTPRIO broken
Message-ID: <20050726120617.GA12338@elte.hu>
References: <42E22D0C.1010608@domdv.de> <20050726102638.GA4000@elte.hu> <4d8e3fd305072604562c8b30d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd305072604562c8b30d1@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:

> 2005/7/26, Ingo Molnar <mingo@elte.hu>:
> [...]
> > [back from KS/OLS]
> > 
> > indeed. The effect of the bug is that RLIMIT_RTPRIO is completely
> > non-functional in 2.6.12.
> > 
> > Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> Ingo, Lee, Andreas,
> the patch seems to be quite simple and is a fix for a regression.
> Is anybody going to FW it to the stable team ?

i'd not put it into stable just yet - the fact that it has not been 
tested in 2.6.12 _at all_ up until very recently means there's little QA 
feedback. Yes, it's simple, but it also triggers something we never did 
before. 2.6.13 ought to be released soon, that should be good enough.

	Ingo
