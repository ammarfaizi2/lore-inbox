Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbTIDKH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 06:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTIDKH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 06:07:27 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:59876 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264901AbTIDKHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 06:07:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@redhat.com>, Paul Mackerras <paulus@samba.org>,
       torvalds@transmeta.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904092915.GA16344@lst.de>
References: <20030903203231.GA8772@lst.de>
	 <16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	 <20030904071334.GA14426@lst.de>
	 <20030904083007.B2473@flint.arm.linux.org.uk>
	 <20030904073845.GA14669@lst.de> <20030904010940.5fa0e560.davem@redhat.com>
	 <20030904092915.GA16344@lst.de>
Message-Id: <1062670026.1820.68.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 12:07:07 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 11:29, Christoph Hellwig wrote:
> On Thu, Sep 04, 2003 at 01:09:40AM -0700, David S. Miller wrote:
> > On Thu, 4 Sep 2003 09:38:45 +0200
> > Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > Umm, right, so the typedef name is also completly bogus, if we're
> > > going to go that route it needs to be something likeb iocookie_t.
> > 
> > My suggestion is to just pass a resource and an offset to ioremap().
> 
> Here's a ioremap_resource implementation.  Tested on ppc32 with a
> converted sungem driver.

Please, make so that ioremap_resource can be passed a PCI IO resource
as well and just do nothing in this case.

Ben.


