Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUH2Lx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUH2Lx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 07:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbUH2Lx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 07:53:28 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:45323 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267751AbUH2Lx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 07:53:27 -0400
Date: Sun, 29 Aug 2004 12:53:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk pull] DRM tree - stop i830/i915 in kernel
Message-ID: <20040829125319.A22787@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408291220330.11976@skynet> <1093779603.2792.19.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1093779603.2792.19.camel@laptop.fenrus.com>; from arjanv@redhat.com on Sun, Aug 29, 2004 at 01:40:04PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 01:40:04PM +0200, Arjan van de Ven wrote:
> On Sun, 2004-08-29 at 13:22, Dave Airlie wrote:
> > Please do a
> > 
> > 	bk pull bk://drm.bkbits.net/drm-2.6
> > 
> > This will include the latest DRM changes and will update the following files:
> 
> please don't do this.
> This makes it not possible for distributions to ship kernels that need
> to work on both old and new X versions....

It just disables to have both builtin, no both modular.  So it shouldn't
be a problem for you, but I wonder what the point is..

