Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVLAH4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVLAH4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 02:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVLAH4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 02:56:11 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:33403 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750757AbVLAH4L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 02:56:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ba4H4Nclyjpyr8AXewzpHj4VVJ6UyLMTv1QSqAHNxmqRKRjN6z/IZ39Wcs/m3/1ARmib0sAgSlJIb7h3SdNNKjQbCVZimO/SbFVtR/NnQICEqlehtz0PaertuFtgZe75yp8V/wZeww1U9gdVi/vzGRSSNtuhfl2Ta/gfpchGKng=
Message-ID: <cda58cb80511302356u536d87dfs@mail.gmail.com>
Date: Thu, 1 Dec 2005 08:56:10 +0100
From: Franck <vagabon.xyz@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20051130.134820.19334664.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051130162327.GC1053@flint.arm.linux.org.uk>
	 <cda58cb80511300845j18c81ce6p@mail.gmail.com>
	 <20051130165546.GD1053@flint.arm.linux.org.uk>
	 <20051130.134820.19334664.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/30, David S. Miller <davem@davemloft.net>:
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Date: Wed, 30 Nov 2005 16:55:47 +0000
>
> > If other CPUs use this then fine, but I find that having config options
> > needlessly available to all architectures is annoying - especially when
> > they are never used.
> >
> > Eg, would you ever expect to see a DM9000 ethernet device on an x86
> > machine?  Probably not - there's far better PCI solutions now.
>
> If I, for example, make changes across the tree to SKB handling, I'd
> like to be able to build as many drivers as possible and fix up the
> compile warnings and build failures before _you_ get to see them.
>
> That's why it's a good idea to make drivers available to as many
> platforms as possible, even if the hardware isn't necessarily
> used there.
>

this would mean that we should change almost all ethernet driver deps ?

thanks
--
               Franck
