Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVEXPF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVEXPF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVEXPF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:05:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41409 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262061AbVEXPFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:05:52 -0400
Date: Tue, 24 May 2005 17:05:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
Message-ID: <20050524150537.GA11829@elte.hu>
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu> <4293420C.8080400@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4293420C.8080400@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > i just noticed that Nick's latest idle-optimizations patch is not in 
> > -rc4-mm2, so this will cause some clashes.
> 
> Yeah, hmm. I've just got lazy with porting to other architectures and 
> sending to Andrew. I'll get it into shape in the next day or so and so 
> this patch will go on top of it hopefully before Andrew is ready to 
> release the next kernel.

we could do it in the other direction just as much - i only touched 3 
architectures. Up to Andrew i guess.

	Ingo
