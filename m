Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbUJ2Tni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUJ2Tni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUJ2TlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:41:21 -0400
Received: from inx.pm.waw.pl ([195.116.170.20]:19396 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261730AbUJ2TUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:20:02 -0400
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: net: generic netdev_ioaddr
References: <1099044244.9566.0.camel@localhost>
	<20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
	<courier.418290EC.00002E85@courier.cs.helsinki.fi>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 29 Oct 2004 21:18:18 +0200
In-Reply-To: <courier.418290EC.00002E85@courier.cs.helsinki.fi> (Pekka J.
 Enberg's message of "Fri, 29 Oct 2004 21:50:20 +0300")
Message-ID: <m3y8hpbaf9.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pekka J Enberg" <penberg@cs.helsinki.fi> writes:

> Yup, I thought about that after I sent the patch. However, as it
> stands now, many network drivers use netdev->base_addr for just that.
> Perhaps it should be nuked completely instead?

I thinks so. With ifmap, SIOCSIFMAP, ifr_map, mem_end etc.,
irq, if_port, dma.
-- 
Krzysztof Halasa
