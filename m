Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWGDEr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWGDEr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 00:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWGDEr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 00:47:57 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:27609 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1750917AbWGDEr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 00:47:56 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306F5027F@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexandre.Bounine@tundra.com,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
Subject: RE: [PATCH] [2.6.17]   Add tsi108 Ethernet device driver support
Date: Tue, 4 Jul 2006 12:47:47 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, 21 Jun 2006 12:00:40 +0800
> Zang Roy-r61911 <tie-fei.zang@freescale.com> wrote:
> 
> > This patch adds a net device driver and configuration options for 
> > Tundra Semiconductor Tsi108 integrated dual port Gigabit Ethernet 
> > controller
> 
> Your patch forgot to include these:
> 
> > +#include <asm/tsi108_irq.h>
> > +#include <asm/tsi108.h>
> 
> Why would a net driver have files in include/asm/?

The net driver is for a tsi108 on chip Ethernet controller.  tsi108_irq provides the Ethernet IRQ number.
tsi108.h provides the hw_info structure. Now tsi108.h has been in the kernel tree. I'd like to provide
the tsi108_irq.h with tsi108  irq support in another patch. Any comment? 

> 
> 
> 
> 
> Have some comments-via-diff, mainly trivial:
> 
Thanks for your patch. It works OK! I will integrate it in my next version.
