Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVHNIrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVHNIrR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 04:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVHNIrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 04:47:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50386 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932286AbVHNIrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 04:47:17 -0400
Date: Sun, 14 Aug 2005 09:47:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Henrik Brix Andersen <brix@gentoo.org>
Cc: Olaf Hering <olh@suse.de>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Watchdog device node name unification
Message-ID: <20050814084715.GA15668@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Henrik Brix Andersen <brix@gentoo.org>, Olaf Hering <olh@suse.de>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <1123969015.13656.13.camel@sponge.fungus> <20050813232519.GA20256@infradead.org> <20050813234322.GA30563@suse.de> <1123978962.13656.21.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123978962.13656.21.camel@sponge.fungus>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 02:22:41AM +0200, Henrik Brix Andersen wrote:
> On Sun, 2005-08-14 at 01:43 +0200, Olaf Hering wrote:
> >  On Sun, Aug 14, Christoph Hellwig wrote:
> > > Please don't.  misdevice.name is a description of the device, and doesn't
> > > have any relation with the name of the device node.
> > 
> > It is used for /class/misc/$name/dev
> 
> ... and for udev-enabled systems, it's the name of the device node to be
> created.

Looks like people never learn.  We had horrible problems with devfs because
it decided to overload existing name fields, but the udev brigade does the same
idiocy again..

