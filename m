Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWBOSOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWBOSOJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWBOSOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:14:09 -0500
Received: from [194.90.237.34] ([194.90.237.34]:55160 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751205AbWBOSOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:14:08 -0500
Date: Wed, 15 Feb 2006 20:15:36 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] add asm-generic/mman.h
Message-ID: <20060215181536.GN12974@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060215151649.GA12090@mellanox.co.il> <1140019088.21448.3.camel@dyn9047017100.beaverton.ibm.com> <20060215165016.GD12974@mellanox.co.il> <1140022377.21448.6.camel@dyn9047017100.beaverton.ibm.com> <20060215170935.GE12974@mellanox.co.il> <Pine.LNX.4.64.0602150916580.3691@g5.osdl.org> <1140025250.21448.15.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140025250.21448.15.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 15 Feb 2006 18:16:02.0296 (UTC) FILETIME=[E0E20780:01C6325B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Badari Pulavarty <pbadari@us.ibm.com>:
> Yes. I did that earlier and checked everything.
> 
> MADV_REMOVE is a known change. Since it added very recently,
> I guess is okay to fix it for real. But if we are going to
> change it, I am hoping to see it very soon in mainline. 
> (Before distros fork-off).

I agree. Andrew, could take this into -mm?
This replaces Roland's fix-up-madv_dontfork-madv_dofork-definitions.patch

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
