Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161427AbWBUID1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161427AbWBUID1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 03:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161426AbWBUID1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 03:03:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16064 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161424AbWBUID0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 03:03:26 -0500
Subject: Re: [PATCH] altix:  export sn_pcidev_info_get
From: Arjan van de Ven <arjan@infradead.org>
To: Mark Maule <maule@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060221024710.GB30226@sgi.com>
References: <20060214162337.GA16954@sgi.com>
	 <20060220201713.GA4992@infradead.org>  <20060221024710.GB30226@sgi.com>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 09:03:14 +0100
Message-Id: <1140508994.3082.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 20:47 -0600, Mark Maule wrote:
> On Mon, Feb 20, 2006 at 08:17:14PM +0000, Christoph Hellwig wrote:
> > On Tue, Feb 14, 2006 at 10:23:37AM -0600, Mark Maule wrote:
> > > Export sn_pcidev_info_get.
> > 
> > Tony or Andrew please back this out again.  The only reason SGI wants this is
> > to support their illegal graphics driver, and no core code uses it.
> > 
> > And Mark, please stop submitting such patches.
> 
> All I'm doing by exporting sn_pcidev_info_get is allowing a module to use
> the SGI SN_PCIDEV_BUSSOFT() macro which will tell a driver which piece of
> altix PCI hw its device is sitting behind (e.g. PCIIO_ASIC_TYPE_TIOCP et. al).
> 
> While I acknowledge that the gfx driver folks requested this, I don't
> understand what is "illegal" about this export, or the driver which wants
> to use it.  What am I missing here?

so you would have no objection to making this a _GPL export ?


