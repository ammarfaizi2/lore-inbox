Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263263AbUJ2Lee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbUJ2Lee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUJ2Leb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:34:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43663 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263267AbUJ2Ldj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:33:39 -0400
Date: Fri, 29 Oct 2004 13:34:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] sched.c: remove an unused macro
Message-ID: <20041029113449.GB32204@elte.hu>
References: <20041028231445.GE3207@stusta.de> <41819D48.7000005@bigpond.net.au> <20041029113147.GE6677@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029113147.GE6677@stusta.de>
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


* Adrian Bunk <bunk@stusta.de> wrote:

> On Fri, Oct 29, 2004 at 11:30:48AM +1000, Peter Williams wrote:
> > 
> > You missed some :-).  The cpu_to_node_mask() macros don't seem to be 
> > used either.
> 
> I only searched for unused static inline functions (since this was 
> relatively easy).
> 
> 
> But your comment seems to be correct, and below is the patch that 
> removes the cpu_to_node_mask macros.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
