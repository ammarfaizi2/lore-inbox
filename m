Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWIETA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWIETA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWIETA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:00:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36587 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030227AbWIETA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:00:56 -0400
Date: Tue, 5 Sep 2006 20:52:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Hua Zhong <hzhong@gmail.com>
Cc: "'Heiko Carstens'" <heiko.carstens@de.ibm.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Daniel Walker'" <dwalker@mvista.com>
Subject: Re: lockdep oddity
Message-ID: <20060905185220.GA24013@elte.hu>
References: <20060905181241.GC16207@elte.hu> <000b01c6d11d$3f528ff0$6721100a@nuitysystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c6d11d$3f528ff0$6721100a@nuitysystems.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4994]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hua Zhong <hzhong@gmail.com> wrote:

> Maybe we should define raw __likely/__unlikely which behave the same 
> way as the vanilla and use them in places like spinlocks to avoid 
> these weird problems.

yes - but only once the true reason for the oddity is debugged.

	Ingo
