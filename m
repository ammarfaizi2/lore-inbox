Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVEXPdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVEXPdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVEXPb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:31:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52676 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262112AbVEXP2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:28:13 -0400
Date: Tue, 24 May 2005 17:27:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
Message-ID: <20050524152759.GA15411@elte.hu>
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu> <4293420C.8080400@yahoo.com.au> <20050524150537.GA11829@elte.hu> <42934748.8020501@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42934748.8020501@yahoo.com.au>
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

> > we could do it in the other direction just as much - i only touched 
> > 3 architectures. Up to Andrew i guess.
> 
> How about just setting need_resched at the start of the cpu_idle 
> function instead? Rather than changing the structure of the idle loops 
> themselves. That would suit me best.

that's fine with me too.

	Ingo
