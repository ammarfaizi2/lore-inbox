Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264422AbRFOPHt>; Fri, 15 Jun 2001 11:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264423AbRFOPHj>; Fri, 15 Jun 2001 11:07:39 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:39180
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S264422AbRFOPHZ>; Fri, 15 Jun 2001 11:07:25 -0400
Date: Fri, 15 Jun 2001 11:07:09 -0400
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <riel@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid !__GFP_IO allocations to eat from memory
 reservations
Message-ID: <651290000.992617629@tiny>
In-Reply-To: <20010614142822Z131175-12594+95@kanga.kvack.org>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, June 14, 2001 09:59:43 AM -0300 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

> 
> In pre3, GFP_BUFFER allocations can eat from the "emergency" memory
> reservations in case try_to_free_pages() fails for those allocations in
> __alloc_pages(). 
> 
> 
> Here goes the (tested) patch to fix that: 

I started testing this because I expected problems under load with reiserfs
on it.  No deadlocks yet though...I owe Marcelo a beer ;-)

-chris

