Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVI0NKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVI0NKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbVI0NKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:10:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:51590 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964923AbVI0NKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:10:10 -0400
Date: Tue, 27 Sep 2005 06:09:38 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Harald Welte <laforge@gnumonks.org>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       vendor-sec@lst.de, security@linux.kernel.org,
       David Brownell <david-b@pacbell.net>
Subject: Re: [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050927130937.GA11060@kroah.com>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <20050927080413.GA13149@kroah.com> <20050927124846.GA29649@infradead.org> <20050927125755.GA10738@kroah.com> <20050927125956.GA29861@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927125956.GA29861@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 01:59:56PM +0100, Christoph Hellwig wrote:
> On Tue, Sep 27, 2005 at 05:57:55AM -0700, Greg KH wrote:
> > Earlier in this thread, on these mailing lists.
> > 
> > I've included it below too.
> 
> Ah, it was last week and I missed it.  sorry.
> 
> This is more than messy.  usbfs is the only user of SI_ASYNCIO, and the
> way it uses it is more than messy.  Why can't USB simply use the proper
> AIO infrastructure?

No one has taken the time and effort to do this.  No other reason that I
know of.  David?  I know you have looked into this a bit in the past.

thanks,

greg k-h
