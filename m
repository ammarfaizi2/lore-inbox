Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290983AbSBSKDd>; Tue, 19 Feb 2002 05:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290993AbSBSKD0>; Tue, 19 Feb 2002 05:03:26 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:51981 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290983AbSBSKDQ>; Tue, 19 Feb 2002 05:03:16 -0500
Date: Tue, 19 Feb 2002 11:02:29 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, Hugh Dickins <hugh@veritas.com>,
        <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
Subject: Re: [RFC] Page table sharing
In-Reply-To: <Pine.LNX.4.33.0202181822470.24671-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0202191059530.22010-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Feb 2002, Linus Torvalds wrote:

> We can, of course, introduce a "pmd-rmap" thing, with a pointer to a
> circular list of all mm's using that pmd inside the "struct page *" of the
> pmd.

Isn't that information basically already available via
vma->vm_(pprev|next)_share?

bye, Roman

