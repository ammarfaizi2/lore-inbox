Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWFBPKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWFBPKn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 11:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWFBPKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 11:10:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46763 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932166AbWFBPKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 11:10:42 -0400
Date: Fri, 2 Jun 2006 17:10:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602151059.GA24735@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <20060602120952.615cea39@localhost> <20060602111053.GA22306@elte.hu> <20060602111704.GA22841@elte.hu> <20060602133403.4eed2de7@localhost> <20060602141349.GA8974@elte.hu> <20060602164624.22ba617e@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602164624.22ba617e@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5006]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paolo Ornati <ornati@fastwebnet.it> wrote:

> On Fri, 2 Jun 2006 16:13:49 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > please try my latest lockdep-combo patch:
> > 
> >   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm2.patch
> > 
> > ontop of vanilla -mm2. The combo patch includes all current -mm2 
> > hotfixes plus all current lockdep fixes.
> 
> It gives me an Oops: "NULL pointer dereference at 
> kmem_cache_alloc+0x23/0x7b" and than a panic (attemp to kill idle 
> task).

ok, i can reproduce that with your full config.

	Ingo
