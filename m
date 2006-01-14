Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWANSOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWANSOO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWANSOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:14:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750734AbWANSON (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 13:14:13 -0500
Date: Sat, 14 Jan 2006 10:13:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch] mm: cleanup bootmem
In-Reply-To: <43C93DA0.3040506@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0601141011300.13339@g5.osdl.org>
References: <43C8F198.3010609@yahoo.com.au> <Pine.LNX.4.64.0601140949460.13339@g5.osdl.org>
 <43C93CCA.9080503@yahoo.com.au> <43C93DA0.3040506@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Jan 2006, Nick Piggin wrote:
> 
> Oh the BITS_PER_LONG batching?

Yes.

>			 That's still completely functional after
> my patch. In fact, as I said in a followup it is likely to work better
> than with David's change to free batched pages as order-0, because I
> reverted back to freeing them as higher order pages.

Ok. Then I doubt anybody will complain. I'm still wondering if some of the 
other ugliness was due to some simulator strangeness issues, but maybe 
even ia64 doesn't care that much any more..

		Linus
