Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWF2Nxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWF2Nxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 09:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWF2Nxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 09:53:52 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:14506 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750719AbWF2Nxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 09:53:49 -0400
Date: Thu, 29 Jun 2006 15:49:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] kernel/lockdep.c: possible cleanups
Message-ID: <20060629134903.GA6706@elte.hu>
References: <20060627015211.ce480da6.akpm@osdl.org> <20060628165500.GV13915@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628165500.GV13915@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> On Tue, Jun 27, 2006 at 01:52:11AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-mm2:
> >...
> > +lockdep-core.patch
> >...
> >  Locking validator
> >...
> 
> This patch contains the following possible cleanups:
> - make the needlessly global variable lockdep_init_error static
> - make the needlessly global lockdep_print_held_locks() static
> - #if 0 the unused global print_lock_classes()
>   (this also implies to #if 0 some static functions)
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

thanks!

  Acked-by: Ingo Molnar <mingo@elte.hu>

i sent a followup cleanup patch to Andrew that removes those #if 0 
sections for real. Let me know if/when you find anything else.

	Ingo
