Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946040AbWBORQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946040AbWBORQR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946039AbWBORQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:16:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:37558 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946031AbWBORQQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:16:16 -0500
Subject: Re: [PATCH] add asm-generic/mman.h
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20060215170935.GE12974@mellanox.co.il>
References: <20060215151649.GA12090@mellanox.co.il>
	 <1140019088.21448.3.camel@dyn9047017100.beaverton.ibm.com>
	 <20060215165016.GD12974@mellanox.co.il>
	 <1140022377.21448.6.camel@dyn9047017100.beaverton.ibm.com>
	 <20060215170935.GE12974@mellanox.co.il>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 09:17:13 -0800
Message-Id: <1140023833.21448.12.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 19:09 +0200, Michael S. Tsirkin wrote:
> Quoting r. Badari Pulavarty <pbadari@us.ibm.com>:
> > MS_SYNC should be 4
> > MS_INVALIDATE should be 2
> 
> Good catch, thanks!
> Other numbers look right, dont they?
> 

Yes. Others look good.

BTW, can we decide on this quickly ? This patch actually changes
MADV_REMOVE value - which was added recently, so no app should
be using it, yet. But a major distro release is basing on current
mainline (2.6.16ish). I hate to see distro release having differnt
values for MADV_ from mainline - distro's will be stuck maintaining
that crap for ever :(

Ack-by: Badari Pulavarty <pbadari@us.ibm.com>

Thanks,
Badari

