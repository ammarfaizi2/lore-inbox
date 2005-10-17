Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVJQS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVJQS2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVJQS2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:28:36 -0400
Received: from mx3.actcom.co.il ([192.114.47.65]:45452 "EHLO
	smtp3.actcom.co.il") by vger.kernel.org with ESMTP id S932193AbVJQS2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:28:35 -0400
Date: Mon, 17 Oct 2005 20:27:55 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Ravikiran G Thirumalai <kiran@scalex86.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, shai@scalex86.org,
       clameter@engr.sgi.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017182755.GA26239@granada.merseine.nu>
References: <20051017093654.GA7652@localhost.localdomain> <200510171740.57614.ak@suse.de> <20051017175231.GA4959@localhost.localdomain> <200510172008.24669.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510172008.24669.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 08:08:24PM +0200, Andi Kleen wrote:
> On Monday 17 October 2005 19:52, Ravikiran G Thirumalai wrote:
> 
> > No they are not.  IBM X460s are generally available machines and  the bug
> > affects those boxes. 
> 
> No reports from that front so far.

We have such machines with >4GB memory and 32 bit DMA capable SCSI
controllers and would like to be able to run 2.6.14 on them when it
comes out...

> > How can there be a major kernel release which is known 
> > to have breakage??
> 
> Welcome to the painful real world of software engineering.
> 
> Every software has bugs and if you want to ever get a release out you
> have to make such decisions sometimes. 

Fair enough, but this is a regression for something that used to
work. If a painful choice is required, how about reverting the patch
that broke it and breaking something that used to be broken?

> As an alternative I can just backout the patch that enables the Intel
> SRAT code. That is probably better for a short term fix and will
> not regress anybody.

Sounds great!

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

