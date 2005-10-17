Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVJQSIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVJQSIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVJQSIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:08:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:750 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932128AbVJQSIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:08:01 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Mon, 17 Oct 2005 20:08:24 +0200
User-Agent: KMail/1.8
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, shai@scalex86.org,
       clameter@engr.sgi.com
References: <20051017093654.GA7652@localhost.localdomain> <200510171740.57614.ak@suse.de> <20051017175231.GA4959@localhost.localdomain>
In-Reply-To: <20051017175231.GA4959@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172008.24669.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 19:52, Ravikiran G Thirumalai wrote:

> No they are not.  IBM X460s are generally available machines and  the bug
> affects those boxes. 

No reports from that front so far.

> How can there be a major kernel release which is known 
> to have breakage??

Welcome to the painful real world of software engineering.

Every software has bugs and if you want to ever get a release out you
have to make such decisions sometimes. 

As an alternative I can just backout the patch that enables the Intel
SRAT code. That is probably better for a short term fix and will
not regress anybody.

-Andi
