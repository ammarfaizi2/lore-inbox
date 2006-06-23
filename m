Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWFWOBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWFWOBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWFWN5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31885 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750716AbWFWNna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:43:30 -0400
Date: Fri, 23 Jun 2006 15:38:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 2/4] lock validator: fix compile warnings in lockdep.c
Message-ID: <20060623133830.GC15113@elte.hu>
References: <20060623132506.GF9446@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623132506.GF9446@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Fix a few compile warnings on 64 bit machines:
> 
> kernel/lockdep.c: In function 'check_chain_key':
> kernel/lockdep.c:1399:
>  warning: format '%016Lx' expects type 'long long unsigned int',
>  but argument 4 has type 'u64'
> kernel/lockdep.c:1399:
>  warning: format '%016Lx' expects type 'long long unsigned int',
>  but argument 5 has type 'u64'
> ...
> 
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Arjan van de Ven <arjan@infradead.org>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
