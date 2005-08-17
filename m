Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVHQIRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVHQIRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 04:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVHQIRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 04:17:18 -0400
Received: from witte.sonytel.be ([80.88.33.193]:48360 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750980AbVHQIRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 04:17:17 -0400
Date: Wed, 17 Aug 2005 10:16:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kumar Gala <kumar.gala@freescale.com>
cc: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Zachary Amsden <zach@vmware.com>,
       linux-kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       "Gala Kumar K.-galak" <galak@freescale.com>
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h> 
In-Reply-To: <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
Message-ID: <Pine.LNX.4.62.0508171016020.6073@numbat.sonytel.be>
References: <20050816.203312.77701192.davem@davemloft.net>
 <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005, Kumar Gala wrote:
> I'm all for killing it off entirely but got some feedback that on i386
> segment.h can be included by userspace programs.
> 
> Here is the in kernel consumers that are outside of arch specific directories:

> ./drivers/video/q40fb.c:#include <asm/segment.h>

M68k-only, so doesn't affect ppc.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
