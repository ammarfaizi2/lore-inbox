Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUCVPn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUCVPn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:43:56 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43294 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262051AbUCVPny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:43:54 -0500
Date: Mon, 22 Mar 2004 15:43:52 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-aa1
In-Reply-To: <20040322145019.GZ3649@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403221541030.11535-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Andrea Arcangeli wrote:
> On Mon, Mar 22, 2004 at 02:31:15PM +0000, Hugh Dickins wrote:
> > 
> > (Aaargh, now we can expect someone to propose
> > CONFIG_PTE_CHAIN_RMAP, CONFIG_ANON_VMA_RMAP, CONFIG_ANONMM_RMAP etc)
.....
> Separating the entry points from the rest of the mm/*.c is sure a good
> idea, and infact I left those separated in objrmap.c, like they were
> separated in rmap.c, so you can go ahead and add an anobjrmap.c and we
> can have a CONFIG_ option to select if to compile with objrmap.c or with
> anobjrmap.c.

You misunderstand me.  I absolutely do not want any such CONFIG_ option.
We agree on what's best, which may well prove to be your implementation,
and stick with that.  Please.

Hugh

