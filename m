Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263698AbUD0CtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbUD0CtD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 22:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbUD0CtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 22:49:02 -0400
Received: from colin2.muc.de ([193.149.48.15]:16399 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263698AbUD0CtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 22:49:00 -0400
Date: 27 Apr 2004 04:48:59 +0200
Date: Tue, 27 Apr 2004 04:48:59 +0200
From: Andi Kleen <ak@muc.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@muc.de>, Darren Hart <dvhltc@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: sched_domains and Stream benchmark
Message-ID: <20040427024859.GC11321@colin2.muc.de>
References: <1N7xQ-7fh-29@gated-at.bofh.it> <m3r7uitr1r.fsf@averell.firstfloor.org> <1083018633.3070.8.camel@farah> <20040427023327.GB11321@colin2.muc.de> <408DC909.7030605@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408DC909.7030605@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now what is wrong with it? I thought you said it is OK

Old problem; STREAM does not scale linearly as it should.

> now that Ingo's balance-on-clone is implemented, and
> that you also saw similar variation in results with
> numasched?

I said it was fixed with Ingo's patch, nothing more. 
The patch isn't in mm5 yet as far as I know.

There were some small variations left (a few percent,
much less than 25%), but these were there even with 2.4. 

-Andi
