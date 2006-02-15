Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423031AbWBOIMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423031AbWBOIMB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423033AbWBOIMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:12:01 -0500
Received: from [194.90.237.34] ([194.90.237.34]:63106 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1423031AbWBOIL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:11:57 -0500
Date: Wed, 15 Feb 2006 10:13:25 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>, William Irwin <wli@holomorphy.com>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK
Message-ID: <20060215081325.GC10026@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org> <Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com> <20060213210906.GC13603@mellanox.co.il> <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com> <Pine.LNX.4.64.0602131426470.3691@g5.osdl.org> <20060213225538.GE13603@mellanox.co.il> <Pine.LNX.4.61.0602132259450.4627@goblin.wat.veritas.com> <20060213233517.GG13603@mellanox.co.il> <43F2AEAE.5010700@yahoo.com.au> <adawtfxqhk1.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adawtfxqhk1.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 15 Feb 2006 08:13:51.0593 (UTC) FILETIME=[C14E4590:01C63207]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <rdreier@cisco.com>:
> Michael, what led you to choose 0x30 and 0x31 for the two new values?
> It does seem that keeping them uniform across architectures is a
> reasonable thing to do, but as far as I can tell the values 9 and 10
> are unused on all architectures, and have the added merit of not
> falling in the parisc reserved range.

No particular reason - I just selected values away from the rest of pack.
Lets go ahead and change them.
 
> Do we still have a chance to change this?
So, any value consistent across architectures will do.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
