Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUHPJuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUHPJuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267501AbUHPJuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:50:21 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:19973 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267495AbUHPJuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:50:18 -0400
Date: Mon, 16 Aug 2004 10:50:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20040816105014.A9367@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org> <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org> <Pine.LNX.4.58.0408161019040.21177@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408161019040.21177@skynet>; from airlied@linux.ie on Mon, Aug 16, 2004 at 10:30:55AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 10:30:55AM +0100, Dave Airlie wrote:
> >
> > Eeek, doing different styles of probing is even worse than what you did
> > before.  Please revert to pci_find_device() util you havea proper common
> > driver ready.
> 
> There was nothing wrong with what we did before it just happened to work
> like 2.4. we are now acting like real 2.6 drivers,

no, now you're acting like an even more broken driver, preventing a fbdev
driver to be loaded afterwards and doing all kinds of funny things.  Please
revert to the old method until you have a common pci_driver for fbdev and dri.

