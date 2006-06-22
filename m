Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWFVLdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWFVLdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWFVLdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:33:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60804 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161078AbWFVLdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:33:46 -0400
Subject: Re: Memory corruption in 8390.c ?
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au,
       snakebyte@gmx.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       netdev@vger.kernel.org
In-Reply-To: <1150976063.15275.146.camel@localhost.localdomain>
References: <20060622023029.GA6156@gondor.apana.org.au>
	 <20060622.012609.25474139.davem@davemloft.net>
	 <20060622083037.GB26083@gondor.apana.org.au>
	 <20060622.013440.97293561.davem@davemloft.net>
	 <1150976063.15275.146.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 13:33:36 +0200
Message-Id: <1150976016.3120.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 12:34 +0100, Alan Cox wrote:
> Ar Iau, 2006-06-22 am 01:34 -0700, ysgrifennodd David Miller:
> > From: Herbert Xu <herbert@gondor.apana.org.au>
> > Date: Thu, 22 Jun 2006 18:30:37 +1000
> > 
> > > On Thu, Jun 22, 2006 at 01:26:09AM -0700, David Miller wrote:
> > > >
> > > > Want me to let this cook in 2.6.18 for a while before sending
> > > > it off to -stable?
> > > 
> > > You know I'm never one to push anything quickly so absolutely yes :)
> > 
> > Ok, applied to net-2.6.18 for now :)
> 
> The 8390 change (corrected version) also makes 8390.c faster so should
> be applied anyway, 

8390 is such a race monster that a few cycles matter a lot! :-)

