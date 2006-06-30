Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWF3Umx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWF3Umx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWF3Umx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:42:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57022 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932182AbWF3Umw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:42:52 -0400
Date: Fri, 30 Jun 2006 22:38:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Message-ID: <20060630203804.GA1950@elte.hu>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com> <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu> <20060630091850.GA10713@elte.hu> <20060630111734.GA22202@gondor.apana.org.au> <20060630113758.GA18504@elte.hu> <a44ae5cd0606301321y6ce6b7dbo2b405d3d76a670f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0606301321y6ce6b7dbo2b405d3d76a670f1@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Miles Lane <miles.lane@gmail.com> wrote:

> I cannot get this patch to apply cleanly to 2.6.17-mm4. Since the 
> patch listed in this message covers the same files as your previous 
> lockdep-annotate-slock.patch, I am assuming this is supposed to 
> replace it.  I should also still apply 
> lockdep-core-add-set-class-and-name.patch, correct?

correct. My latest combo patch has it all included, it's at:

  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-mm4.patch

could you try that one?

	Ingo
