Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbULBATZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbULBATZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbULBAR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:17:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:4523 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261515AbULBAKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 19:10:30 -0500
Date: Wed, 1 Dec 2004 16:10:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
In-Reply-To: <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Dec 2004, Christoph Lameter wrote:
>
> Changes from V11->V12 of this patch:
> - dump sloppy_rss in favor of list_rss (Linus' proposal)
> - keep up against current Linus tree (patch is based on 2.6.10-rc2-bk14)
> 
> This is a series of patches that increases the scalability of
> the page fault handler for SMP. Here are some performance results
> on a machine with 512 processors allocating 32 GB with an increasing
> number of threads (that are assigned a processor each).

Ok, consider me convinced. I don't want to apply this before I get 2.6.10 
out the door, but I'm happy with it. I assume Andrew has already picked up 
the previous version.

		Linus
