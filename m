Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWCOPrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWCOPrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbWCOPrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:47:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5867 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751982AbWCOPrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:47:11 -0500
Subject: Re: PATCH: rio driver rework continued  #2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060315143301.GA7790@mipter.zuzino.mipt.ru>
References: <1142425657.5597.13.camel@localhost.localdomain>
	 <20060315143301.GA7790@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2006 15:53:17 +0000
Message-Id: <1142437997.5597.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-15 at 17:33 +0300, Alexey Dobriyan wrote:
> >  	rio_dprintk(RIO_DEBUG_PARAM, "can_add_transmit() returns %x\n", res);
> > -	rio_dprintk(RIO_DEBUG_PARAM, "Packet is 0x%x\n", (int) PacketP);
> > +	rio_dprintk(RIO_DEBUG_PARAM, "Packet is 0x%p\n", PacketP);
> 						^^^^
> 
> Just %p.

Thanks .. good point. Will go whack all those on the head once I've
finished this batch of changes to remove even more typedefery

