Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWBMTAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWBMTAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWBMTAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:00:48 -0500
Received: from [194.90.237.34] ([194.90.237.34]:24488 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S964774AbWBMTAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:00:47 -0500
Date: Mon, 13 Feb 2006 21:02:06 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: William Irwin <wli@holomorphy.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: madvise MADV_DONTFORK/MADV_DOFORK
Message-ID: <20060213190206.GC12458@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.61.0602131754430.8653@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602131754430.8653@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 13 Feb 2006 19:02:34.0656 (UTC) FILETIME=[0C6EDA00:01C630D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Hugh Dickins <hugh@veritas.com>:
> > Add madvise options to control whether memory range is inherited across fork.
> > Useful e.g. for when hardware is doing DMA from/into these pages.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> 
> Looks good to me, Michael (but Gleb's eye has always proved better than
> mine).  Just a couple of adjustments I'd ask before you send to Andrew: 

Gleb has acked this to me in a private mail.
Right, Gleb?

...

> 
> 2. Your two-line changeset comment should be expanded:

OK, thanks, I'll work on an appropriate description.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
