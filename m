Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265006AbSJWOH2>; Wed, 23 Oct 2002 10:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265014AbSJWOH2>; Wed, 23 Oct 2002 10:07:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26589 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S265006AbSJWOH1>;
	Wed, 23 Oct 2002 10:07:27 -0400
Date: Wed, 23 Oct 2002 16:20:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@zip.com.au>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
In-Reply-To: <20021023115026.GB30182@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0210231618150.10431-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Oct 2002, Andrea Arcangeli wrote:

> it's not another vma tree, furthmore another vma tree indexed by the
> hole size wouldn't be able to defragment and it would find the best fit
> not the first fit on the left.

what i was talking about was a hole-tree indexed by the hole start
address, not a vma tree indexed by the hole size. (the later is pretty
pointless.) And even this solution still has to search the tree linearly
for a matching hole.

	Ingo

