Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318988AbSH1Vgv>; Wed, 28 Aug 2002 17:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318990AbSH1Vgv>; Wed, 28 Aug 2002 17:36:51 -0400
Received: from dp.samba.org ([66.70.73.150]:10429 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318988AbSH1Vgu>;
	Wed, 28 Aug 2002 17:36:50 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15725.17098.681128.713398@argo.ozlabs.ibm.com>
Date: Thu, 29 Aug 2002 07:38:18 +1000 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: "Clemens 'Gullevek' Schwaighofer" <schwaigl@eunet.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: still ati fb errors with 2.5.31, thought patch applied
In-Reply-To: <Pine.LNX.4.33.0208281114420.1459-100000@maxwell.earthlink.net>
References: <46344979984.20020828090546@eunet.at>
	<Pine.LNX.4.33.0208281114420.1459-100000@maxwell.earthlink.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons writes:

> > aty128fb.c: In function `aty128_pci_register':
> > aty128fb.c:1730: too many arguments to function `aty128find_ROM'
> > aty128fb.c:1736: warning: passing arg 1 of `aty128_get_pllinfo' from incompatible pointer type
> > aty128fb.c:1749: structure has no member named `mtrr'
> > aty128fb.c:1750: structure has no member named `vram_size'
> > aty128fb.c:1751: structure has no member named `mtrr'
> > aty128fb.c: At top level:
> > aty128fb.c:1402: warning: `aty128fb_rasterimg' defined but not used

> This driver has not been ported to the new api.

I sent you a patch to convert aty128fb.c to the new API, and I posted
a message to lkml saying that it was available at:

ftp://ftp.samba.org/pub/paulus/aty128.patch

It's about 112kB uncompressed, so I didn't include it in the mail to
lkml, but I'll send it to anyone who asks.

Paul.
