Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423033AbWBOIRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423033AbWBOIRd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423034AbWBOIRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:17:33 -0500
Received: from [194.90.237.34] ([194.90.237.34]:43397 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1423033AbWBOIRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:17:31 -0500
Date: Wed, 15 Feb 2006 10:18:57 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, hugh@veritas.com,
       wli@holomorphy.com, gleb@minantech.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       vandrove@vc.cvut.cz, pbadari@us.ibm.com, grundler@parisc-linux.org,
       matthew@wil.cx
Subject: Re: [PATCH] Fix up MADV_DONTFORK/MADV_DOFORK definitions
Message-ID: <20060215081857.GD10026@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060213210906.GC13603@mellanox.co.il> <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com> <Pine.LNX.4.64.0602131426470.3691@g5.osdl.org> <20060213225538.GE13603@mellanox.co.il> <Pine.LNX.4.61.0602132259450.4627@goblin.wat.veritas.com> <20060213233517.GG13603@mellanox.co.il> <43F2AEAE.5010700@yahoo.com.au> <adawtfxqhk1.fsf@cisco.com> <20060214221654.67288424.akpm@osdl.org> <adaslqlqgdz.fsf_-_@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaslqlqgdz.fsf_-_@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 15 Feb 2006 08:19:23.0359 (UTC) FILETIME=[870DBEF0:01C63208]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply.

Quoting Roland Dreier <rdreier@cisco.com>:
> Change MADV_DONTFORK and MADV_DOFORK to be 9 and 10 respectively.
> These values are unused on all architectures and safely outside of the
> parisc reserved range.  Define the values in decimal or hex to match
> the surrounding style for each architecture.  While we're touching all
> this, change the comments from "dont inherit" to "don't inherit."
> 
> Signed-off-by: Roland Dreier <rolandd@cisco.com>

Acked-by: Michael S. Tsirkin <mst@mellanox.co.il>
Thanks,

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
