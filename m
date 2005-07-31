Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVGaLIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVGaLIg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVGaLIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:08:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30856 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261687AbVGaLHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:07:41 -0400
Date: Sun, 31 Jul 2005 12:07:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [git patches] new wireless stuffs
Message-ID: <20050731110736.GA4020@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Netdev List <netdev@vger.kernel.org>
References: <42EC0C3E.7030705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EC0C3E.7030705@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 07:24:46PM -0400, Jeff Garzik wrote:
> 
> If this is post-2.6.13 material, that's fine.
> 
> I've been getting tired of the slow movement of wireless.  A little bit 
> of that is my fault, certainly.  I've also been wanting to get these net 
> drivers out to Linux users.
> 
> This adds HostAP, ipw2100, ipw2200, and the generic ieee80211 code.  The 
> only -changes- in this set are cosmetic.

Any chance we can give the hostap driver a better name?  hostap describes
the AP mode it can operate on, but it should really be named after the hardware
it supports in some way.

