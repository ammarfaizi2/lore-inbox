Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVAFBwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVAFBwD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 20:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVAFBwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 20:52:03 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63764
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262699AbVAFBwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 20:52:01 -0500
Date: Thu, 6 Jan 2005 02:52:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050106015211.GI4597@dualathlon.random>
References: <20050105180651.GD4597@dualathlon.random> <Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com> <20050105174934.GC15739@logos.cnet> <20050105134457.03aca488.akpm@osdl.org> <20050105203217.GB17265@logos.cnet> <41DC7D86.8050609@yahoo.com.au> <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <41DC955D.9020505@yahoo.com.au> <20050105173739.2d91deb3.akpm@osdl.org> <41DC971F.9030705@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DC971F.9030705@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 12:40:47PM +1100, Nick Piggin wrote:
> I thought it sounded like he implied that nr_scanned was insufficient
> (otherwise he might have said "to wait on ... but my patch fixes it").

BTW, from my part I can't reproduce it (even without the nr_scanned,
that I'm going to apply too anyway just in case), but my hardware may
have different timings dunno.

All I could reproduce were the swap-token issues (I had a flood of
reports about that too, all fixed by now with my 1-6/4 patches). The
other patches agreed here looks good but I don't have actual pending
bugs on that side and I can't reproduce problems either in basic
testing, so they're applied now for correctness.

Thanks.
