Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVCIKZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVCIKZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVCIKZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:25:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28391 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262252AbVCIKZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:25:13 -0500
Subject: Re: [RFC] -stable, how it's going to work.
From: Arjan van de Ven <arjan@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050309101728.A17289@flint.arm.linux.org.uk>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de>
	 <1110363060.6280.74.camel@laptopd505.fenrus.org>
	 <20050309101728.A17289@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 11:24:58 +0100
Message-Id: <1110363899.6280.77.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 10:17 +0000, Russell King wrote:
> On Wed, Mar 09, 2005 at 11:10:59AM +0100, Arjan van de Ven wrote:
> > On Wed, 2005-03-09 at 10:56 +0100, Andi Kleen wrote:
> > > One rule I'm missing:
> > > 
> > > - It must be accepted to mainline. 
> > > 
> > 
> > I absolutely agree with Andi on this one.
> 
> What about the case (as highlighted in previous discussions) that the
> stable tree needs a simple "dirty" fix, whereas mainline takes the
> complex "clean" fix?

that's the exception I talked about a bit later in my mail. It should be
rare and very deliberate. And in fact once the mainline change ripples
out into maturity I rather replace the -stable one with that later on,
even if it's a bit more invasive. 

