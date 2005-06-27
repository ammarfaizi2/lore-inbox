Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVF0Jqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVF0Jqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVF0Jqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:46:34 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:35670 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261649AbVF0JqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:46:24 -0400
Message-ID: <42BFCAE7.6070708@yahoo.com.au>
Date: Mon, 27 Jun 2005 19:46:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com> <1119609680.17066.81.camel@localhost.localdomain> <20050627091808.GC11013@nysv.org>
In-Reply-To: <20050627091808.GC11013@nysv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Törnqvist wrote:

 > I can't find the original post I'm thinking about but
 > http://lkml.org/lkml/2005/5/16/68 says essentially the same thing.

The scheduler is being improved for better behaviour on complex
topologies like multi core + NUMA and multi level NUMA systems.
If Con's work had gone in first, then conversely these improvements
would have had to wait.

> There's also my all-time favorite, http://lkml.org/lkml/2005/3/14/4
> 

What's wrong with that? The slowdown is due to the workload
becoming disk bound. The reasons are still not entirely clear,
but I don't think it is a recent (ie. 2.6) regression (or even
a regression at all IIRC).

> The lack of QA seems appalling here, and I'm sure Reiser has had
> to do more of that for DARPA than most linux kernel hackers around.
> 

And what QA would you have preferred?

I think if you are resorting to bringing up all time favourite
blunders when trying to justify Reiser4 being included, then
that is a sign right there that something is fundamentally wrong
(if not with the code, then with your line of thought0

And note my email has nothing to do with any *real* argument for
or against R4.

Thanks,
Nick

Send instant messages to your online friends http://au.messenger.yahoo.com 
