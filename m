Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbTBPNBN>; Sun, 16 Feb 2003 08:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbTBPNBM>; Sun, 16 Feb 2003 08:01:12 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16518
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266749AbTBPNBM>; Sun, 16 Feb 2003 08:01:12 -0500
Subject: Re: PATCH: header update for arcnet updates (again to match 2.4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1045390711.2068.44.camel@imladris.demon.co.uk>
References: <E18k81g-0007KU-00@the-village.bc.nu>
	 <1045390711.2068.44.camel@imladris.demon.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045404715.16464.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Feb 2003 14:11:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-16 at 10:18, David Woodhouse wrote:
> >  /* The number of low I/O ports used by the card. */
> > -#define ARCNET_TOTAL_SIZE 9
> > +#define ARCNET_TOTAL_SIZE 8
> 
> Er, is this definitely right?
> 
> Don't we often have the hardware address in a set of DIP switches at
> ioaddr+8?

On the 20020 ?

If so I need to make the size conditional on card

