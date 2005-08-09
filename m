Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVHITlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVHITlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVHITlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:41:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8976 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932283AbVHITlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:41:06 -0400
Date: Tue, 9 Aug 2005 20:41:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Message-ID: <20050809204100.B29945@flint.arm.linux.org.uk>
Mail-Followup-To: "Martin J. Bligh" <mbligh@mbligh.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, ncunningham@cyclades.com,
	Daniel Phillips <phillips@arcor.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>,
	Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de> <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au> <20050809080853.A25492@flint.arm.linux.org.uk> <523240000.1123598289@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <523240000.1123598289@[10.10.2.4]>; from mbligh@mbligh.org on Tue, Aug 09, 2005 at 07:38:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 07:38:52AM -0700, Martin J. Bligh wrote:
> pfn_valid() doesn't tell you it's RAM or not - it tells you whether you
> have a backing struct page for that address. Could be an IO mapped device,
> a small memory hole, whatever.

The only things which have a struct page is RAM.  Nothing else does.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
