Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbTIBX7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 19:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTIBX7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 19:59:09 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:36281 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261418AbTIBX7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 19:59:07 -0400
Date: Tue, 2 Sep 2003 16:59:00 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jamie Lokier <jamie@shareable.org>,
       "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030902235900.GA5769@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jamie Lokier <jamie@shareable.org>,
	"Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
	linux-kernel@vger.kernel.org
References: <1062188787.4062.21.camel@elenuial.steamballoon.com> <20030901091524.A15370@flint.arm.linux.org.uk> <20030901101224.GB1638@mail.jlokier.co.uk> <20030901151710.A22682@flint.arm.linux.org.uk> <20030901165239.GB3556@mail.jlokier.co.uk> <20030901181148.C22682@flint.arm.linux.org.uk> <20030902053415.GA7619@mail.jlokier.co.uk> <20030902091553.A29984@flint.arm.linux.org.uk> <20030902115731.GA14354@mail.jlokier.co.uk> <20030902195222.D9345@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902195222.D9345@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 07:52:22PM +0100, Russell King wrote:
> Multiple mappings of the same object rarely occur in my experience, so
> the resulting performance loss caused by working around the cache and
> writebuffer is something we can live with.

Multiple *writable* mappings.   Don't forget about libc et al.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
