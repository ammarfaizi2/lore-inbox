Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263980AbRFRN4K>; Mon, 18 Jun 2001 09:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263978AbRFRN4C>; Mon, 18 Jun 2001 09:56:02 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:25107 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263970AbRFRNz4>; Mon, 18 Jun 2001 09:55:56 -0400
Date: Mon, 18 Jun 2001 15:55:31 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Colonel <klink@clouddancer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20010618155531.A21070@artax.karlin.mff.cuni.cz>
In-Reply-To: <20010613015519.151BF78599@mail.clouddancer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010613015519.151BF78599@mail.clouddancer.com>; from klink@clouddancer.com on Tue, Jun 12, 2001 at 06:55:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So it seems that PnP finds the card, but the connections (or even the
> forced values) to the sb module fail.  Back when this was a single
> processor machine, but still running 2.4 kernel, a windoze
> installation found the SB at the listed interface parameters.
> 
> 
> Anyone have a solution?
> 
> Same problem without modules.conf settings, valid version of mod
> utilities, a web search did not help,...

I had a similar problem with different card (Gravi Usltrasound PnP).
The solution turned out to be to avoid dma 1 channel. May be some BIOSes
or ISA chipsets got the 8-bit dma channels handling wrong, but I really
don't know. Btw: for me 2.2.x autodetected right, 2.4.x need explicit setting.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
