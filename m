Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVE3QbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVE3QbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 12:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVE3QbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 12:31:19 -0400
Received: from 65-102-103-67.albq.qwest.net ([65.102.103.67]:18123 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261637AbVE3QbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 12:31:16 -0400
Date: Mon, 30 May 2005 10:33:14 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: kus Kusche Klaus <kus@keba.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, James Bruce <bruce@andrew.cmu.edu>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: RE: RT patch acceptance
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323224@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.61.0505301020020.12903@montezuma.fsmlabs.com>
References: <AAD6DA242BC63C488511C611BD51F367323224@MAILIT.keba.co.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, kus Kusche Klaus wrote:

> I didn't state that a hard-RT linux is simpler, technically 
> (however, personally, I believe that once RT linux is there, *our*
> job of writing RT applications, device drivers, ... will be simpler
> compared to a nanokernel approach).

I can't quite see how, in my experience they involve the same 
effort, but i guess that's personal opinion.

> I just stated that for the management, with its limited interest and
> understanding of deep technical details (and, in our case, with bad 
> experiences with RT plus non-RT OS solutions), a one-system solution
> *sounds* much simpler, easier to understand, and easier to manage.
>
> Decisions in companies aren't based on purely technical facts,
> sometimes not even on rational arguments...

But decisions for the Linux kernel must always be rational and technical. 
Regarding ease of maintenance, debugging/maintaining an application on a  
nanokernel (ie isolated) is a lot easier than something as large and 
complex as the Linux kernel. This also applies for QA and general 
verification.

> And concerning support:
> 
> * If we go the "pure linux" way, we may (or may not) get help from
> the community for our problems (it did work quite well up to now), 
> or we could buy commercial linux support.

Considering how controlling your management is, i'm surprised you'd stake 
your business on something as non deterministic as the Linux kernel 
mailing list.

> * If we go the "nanokernel plus guest linux" way, we will not get 
> support from the nanokernel company for general linux kernel issues, 

I find that hard to believe literally any company which sells you 
operating system software will be more than willing to provide you support 
for the supplied components, obviously at a price but they are after all 
in the business of making money.

> the community help will also be close to zero, because we no
> longer have a pure linux system, and the community is not able to
> reproduce and analyze our problems any longer (in the same way lkml
> is rather unable to help on vendor linux kernels or on tainted
> kernels), and the same holds for most companies offering commercial
> linux support.

A volunteer supported public forum as a means of handling technical issues 
for a company doesn't sound like a good idea.

> Hence, w.r.t. support, the nanokernel approach looks much worse. 

I can't quite see how you drew that conclusion. The fact is, pay someone 
and they'll resolve your problems.

Regards,
	Zwane
