Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbVCMITV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbVCMITV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 03:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbVCMITV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 03:19:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39046 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263446AbVCMISl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 03:18:41 -0500
Subject: Re: nvidia fb licensing issue.
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       adaplas@pol.net
In-Reply-To: <20050312215936.513039a6.akpm@osdl.org>
References: <20050313042459.GF32494@redhat.com>
	 <20050312215936.513039a6.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 13 Mar 2005 09:18:33 +0100
Message-Id: <1110701914.6278.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-12 at 21:59 -0800, Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> > The nvidia framebuffer code added recently is marked as
> >  MODULE_LICENSE(GPL), but some things seem a little odd to me..
> > 
> >  1. The boilerplate at the top of drivers/video/nvidia/nv_dma.h,
> >     drivers/video/nvidia/nv_local.h, and drivers/video/nvidia/nv_hw.c
> >     doesn't seem to be a GPL-compatible license. It seems to be an nvidia
> >     specific license with an advertising clause, and something that
> >     adds restrictions on rights of U.S. Govt end users.
> > 
> >  2. Some of these files clearly came from XFree86 judging from
> >     the CVS idents in the source.  Was this XFree86 code
> >     dual-licensed by its original authors ? If so, it isn't clear.
> 
> Does
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm3/broken-out/fbdev-nvidia-licensing-clarification.patch
> 
> clear things up?

somewhat; it would even make sense to consider dual licensing that thing
(like most other not-originally-gpl code in the kernel) to clarify the
legal status for real. Otherwise if you merge it with GPL it sort of
becomes GPL only.. (due to the freedom of MIT and the viral nature of
GPL) and I suspect the intention of the author was to keep allowing MIT
use...

