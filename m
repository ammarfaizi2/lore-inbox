Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314231AbSEBCia>; Wed, 1 May 2002 22:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314232AbSEBCi3>; Wed, 1 May 2002 22:38:29 -0400
Received: from holomorphy.com ([66.224.33.161]:35284 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314231AbSEBCi2>;
	Wed, 1 May 2002 22:38:28 -0400
Date: Wed, 1 May 2002 19:37:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502023711.GF32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <E172gnj-0001pS-00@starship> <20020502024740.P11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 02:47:40AM +0200, Andrea Arcangeli wrote:
> Oh yeah, you save 1 microsecond every 10 years of uptime by taking
> advantage of the potentially coalesced cacheline between the last page
> in a node and the first page of the next node. Before you can care about
> this optimizations you should remove from x86 the pgdat loops that are
> not needed with discontigmem disabled like in x86 (this has nothing to
> do with discontigmem/nonlinear). That wouldn't be measurable too but at
> least it would be more worthwhile.

Which ones did you have in mind? I did poke around this area a bit, and
already have my eye on one...


Cheers,
Bill
