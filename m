Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWBNGwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWBNGwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbWBNGwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:52:45 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:7801 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1030420AbWBNGwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:52:44 -0500
Date: Tue, 14 Feb 2006 08:51:45 +0200
From: Gleb Natapov <gleb@minantech.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>, William Irwin <wli@holomorphy.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: madvise MADV_DONTFORK/MADV_DOFORK
Message-ID: <20060214065145.GE24524@minantech.com>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.61.0602131754430.8653@goblin.wat.veritas.com> <20060213190206.GC12458@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213190206.GC12458@mellanox.co.il>
X-OriginalArrivalTime: 14 Feb 2006 06:52:43.0123 (UTC) FILETIME=[410EF430:01C63133]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 09:02:06PM +0200, Michael S. Tsirkin wrote:
> Quoting r. Hugh Dickins <hugh@veritas.com>:
> > > Add madvise options to control whether memory range is inherited across fork.
> > > Useful e.g. for when hardware is doing DMA from/into these pages.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> > 
> > Looks good to me, Michael (but Gleb's eye has always proved better than
> > mine).  Just a couple of adjustments I'd ask before you send to Andrew: 
> 
> Gleb has acked this to me in a private mail.
> Right, Gleb?
> 
Sory to be late :)

Yes the patch is looking good.

Acked-by: Gleb Natapov <glebn@voltaire.com>

--
			Gleb.
