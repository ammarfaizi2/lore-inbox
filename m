Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUJ0BDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUJ0BDa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 21:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUJ0BDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 21:03:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8374 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261520AbUJ0BAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 21:00:34 -0400
Date: Tue, 26 Oct 2004 21:00:11 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@novell.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: lowmem_reserve (replaces protection)
In-Reply-To: <20041027005425.GO14325@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0410262059020.21548-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Andrea Arcangeli wrote:

> the per-classzone kswapd treshold was very well taken care of in 2.4,
> thanks the watermarks embedding the low/min/high and the classzone being
> passed up to the kswapd wakeup function.

And it works fine on non-numa x86.

However, doesn't the protection also serve a purpose for
NUMA fallback ?  How is that handled by your code ?

NUMA wasn't very important a few years ago, but with AMD64
systems being common, it is an important consideration now.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

