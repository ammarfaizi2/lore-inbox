Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289379AbSBSDHF>; Mon, 18 Feb 2002 22:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289455AbSBSDGz>; Mon, 18 Feb 2002 22:06:55 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:10899 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289379AbSBSDGs>;
	Mon, 18 Feb 2002 22:06:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 04:11:25 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Hugh Dickins <hugh@veritas.com>,
        <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202181822470.24671-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202181822470.24671-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16d0gh-0000zn-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 03:35 am, Linus Torvalds wrote:
> Right now the rmap patches just make the pointer point directly to
> the one exclusive mm that holds the pmd, right?

To be precise, the pte_chain ends up at an entry on the page table and
we get to the mm through the page table's struct page.

-- 
Daniel
