Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUABAFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUABAFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:05:23 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:57797 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S261270AbUABAFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:05:18 -0500
Date: Fri, 2 Jan 2004 00:45:53 +0100
From: Matthias Urlichs <smurf@smurf.noris.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 357] Mac89x0 Ethernet (fwd)
Message-ID: <20040101234553.GA25669@play.smurf.noris.de>
References: <Pine.GSO.4.58.0401012146370.2916@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0401012146370.2916@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.0-gpgme-021125a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Macintosh CS89x0 Ethernet: Netif updates (from Matthias Urlichs)
> >
Thanks -- I'll try to find some time to look at this more closely.

> > +	/* Write the contents of the packet */
> > +	memcpy((void *)(dev->mem_start + PP_TxFrame), skb->data, skb->len+1);
> 
> Is dev->mem_start DMA memory?

All I can say that it works as-posted.
There's a reason I removed the BROKEN tag...

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Never kick a man, unless he's down.
