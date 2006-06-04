Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932229AbWFDLCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWFDLCu (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 07:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWFDLCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 07:02:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43966 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932229AbWFDLCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 07:02:49 -0400
Date: Sun, 4 Jun 2006 13:02:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>
Subject: Re: [patch, -rc5-mm3] lock validator: fix ns83820.c irq-flags part 3
Message-ID: <20060604110207.GA21558@elte.hu>
References: <20060604083017.GA8241@elte.hu> <1149411525.3109.73.camel@laptopd505.fenrus.org> <986ed62e0606040253pfe9c300qf88029f88ae65039@mail.gmail.com> <1149415707.3109.96.camel@laptopd505.fenrus.org> <986ed62e0606040346v74c7761bpb427cc554aef40d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606040346v74c7761bpb427cc554aef40d@mail.gmail.com>
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


* Barry K. Nathan <barryn@pobox.com> wrote:

> On 6/4/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> >ok this is a real driver deadlock:
> [snip]
> 
> With this third patch added, it boots cleanly, with no lockdep 
> messages. (And, each time, I've been checking things by sshing into 
> the box via the ns83820 NIC, so I can also confirm that the card works 
> with these patches.)

great and thanks for all the testing!

	Ingo
