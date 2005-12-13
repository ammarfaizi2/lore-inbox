Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVLMFUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVLMFUO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 00:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVLMFUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 00:20:14 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:58529 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932462AbVLMFUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 00:20:12 -0500
Date: Mon, 12 Dec 2005 21:20:39 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: vatsa@in.ibm.com, Keith Owens <kaos@ocs.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Message-ID: <20051213052039.GA12539@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1134344716.5937.11.camel@localhost.localdomain> <18382.1134348547@ocs3.ocs.com.au> <20051212084112.GA3934@in.ibm.com> <439DD082.9508C87C@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439DD082.9508C87C@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 10:33:22PM +0300, Oleg Nesterov wrote:
> Srivatsa Vaddagiri wrote:
> 
> > P.S :- Thanks to everybody who reponded clarifying this subject.
> 
> Yes! it was really helpful, thanks to all. I think it would be great
> to have Paul's very clear (and short!) explanation somewhere in
> Documentation/.

Glad you liked it!

I need to do an RCU documentation update soon anyway, so will include
memory barriers in that update.

							Thanx, Paul
