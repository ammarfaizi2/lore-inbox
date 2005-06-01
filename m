Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVFAOld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVFAOld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVFAOld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:41:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44021 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261394AbVFAOlb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:41:31 -0400
Date: Wed, 1 Jun 2005 07:39:37 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, <hch@infradead.org>,
       <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: RT patch acceptance
In-Reply-To: <20050601143202.GI5413@g5.random>
Message-ID: <Pine.LNX.4.44.0506010735450.23057-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Andrea Arcangeli wrote:

> Then I'm afraid preempt-RT infringe on the patent that they take after
> years of doing that in linux. I'm not a lawyer but you may want to
> check before investing too much on this for the next 15 years. The
> nanokernel thing has happened exactly because they couldn't wrap the cli
> calls to do something different than a cli AFIK. Nanokernel was a nice
> workaround to avoid having to us the patented irq disable redefine.
> 
> I assumed you weren't infringing on the patent and in turn disabling irq
> locally would actually do that, sorry.

This is questionable. It doesn't seem reasonable that you could infringe 
on patent by simply not disabling interrupts. There is no interrupt 
disable replacement in the RT patch .

 
Daniel

