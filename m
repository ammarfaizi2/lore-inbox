Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWDKW3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWDKW3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWDKW3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:29:38 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:12183 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751173AbWDKW3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:29:37 -0400
Date: Wed, 12 Apr 2006 00:30:24 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@davemloft.net>, mb@bu3sch.de,
       netdev@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, linville@tuxdriver.com
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
Message-ID: <20060411223024.GA6543@ens-lyon.fr>
References: <1144719972.19353.24.camel@localhost.localdomain> <20060410.224933.39567033.davem@davemloft.net> <1144788541.19353.41.camel@localhost.localdomain> <20060411.143407.74615246.davem@davemloft.net> <1144794077.19353.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144794077.19353.53.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 08:21:17AM +1000, Benjamin Herrenschmidt wrote:
> 
> > I still think we shouldn't reward shit hardware by complicating
> > up our DMA mappings internals. :-)
> 
> BTW. In the meantime, can't that driver work in PIO only mode ?

yes, I think you just have to have the pci_set_dma_mask fail with
DMA30BIT_MASK.

regards,

Benoit

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
