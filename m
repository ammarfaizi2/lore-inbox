Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbTICHbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTICHbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:31:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54284 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261455AbTICHbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:31:23 -0400
Date: Wed, 3 Sep 2003 08:31:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Larry McVoy <lm@work.bitmover.com>, Jamie Lokier <jamie@shareable.org>,
       "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030903083118.A17670@flint.arm.linux.org.uk>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jamie Lokier <jamie@shareable.org>,
	"Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
	linux-kernel@vger.kernel.org
References: <20030901091524.A15370@flint.arm.linux.org.uk> <20030901101224.GB1638@mail.jlokier.co.uk> <20030901151710.A22682@flint.arm.linux.org.uk> <20030901165239.GB3556@mail.jlokier.co.uk> <20030901181148.C22682@flint.arm.linux.org.uk> <20030902053415.GA7619@mail.jlokier.co.uk> <20030902091553.A29984@flint.arm.linux.org.uk> <20030902115731.GA14354@mail.jlokier.co.uk> <20030902195222.D9345@flint.arm.linux.org.uk> <20030902235900.GA5769@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030902235900.GA5769@work.bitmover.com>; from lm@bitmover.com on Tue, Sep 02, 2003 at 04:59:00PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 04:59:00PM -0700, Larry McVoy wrote:
> On Tue, Sep 02, 2003 at 07:52:22PM +0100, Russell King wrote:
> > Multiple mappings of the same object rarely occur in my experience, so
> > the resulting performance loss caused by working around the cache and
> > writebuffer is something we can live with.
> 
> Multiple *writable* mappings.   Don't forget about libc et al.

I mean in the same group of threads with the same struct mm, not the whole
system.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

