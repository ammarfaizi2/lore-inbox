Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVAMIqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVAMIqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVAMIqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:46:18 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:56010 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261303AbVAMIqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:46:02 -0500
Subject: Re: [PATCH] kill symbol_get & friends
From: David Woodhouse <dwmw2@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, adaplas@pol.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105575573.12794.27.camel@localhost.localdomain>
References: <20050112203136.GA3150@lst.de>
	 <1105575573.12794.27.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 08:45:37 +0000
Message-Id: <1105605937.30759.80.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 11:19 +1100, Rusty Russell wrote:
> The lack of users is because, firstly, dynamic dependencies are less
> common than static ones, and secondly because the remaining inter-module
> users (AGP and mtd) have not been converted.  Patches have been sent
> several times, but maintainers are distracted, it seems.  I *will* run
> out of patience and push those patches which take away intermodule.c one
> day (hint, hint!).

I'd be more than happy to see the back of the intermodule crap. I don't
recall seeing patches to remove it again that I'm happy with -- although
you're right, I'm easily distracted.

I'd actually like to go through the whole CFI chip probe and command set
selection crap, understand it all again, and make myself happy with it
rather than just hacking it up further. It's too convoluted, and some of
the reasons for that are no longer relevant.

(Please don't use my broken SPF-afflicted email address, btw. That
address should no longer be present in the kernel sources or
MAINTAINERS.)

-- 
dwmw2


