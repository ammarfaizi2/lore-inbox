Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUHPMVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUHPMVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUHPMU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:20:56 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:26117 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267576AbUHPMU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:20:28 -0400
Date: Mon, 16 Aug 2004 13:20:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: your mail
Message-ID: <20040816132022.A10567@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@linux.ie>,
	torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org> <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org> <Pine.LNX.4.58.0408161019040.21177@skynet> <20040816105014.A9367@infradead.org> <1092654719.20523.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1092654719.20523.18.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 16, 2004 at 12:12:00PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 12:12:00PM +0100, Alan Cox wrote:
> On Llu, 2004-08-16 at 10:50, Christoph Hellwig wrote:
> > no, now you're acting like an even more broken driver, preventing a fbdev
> > driver to be loaded afterwards and doing all kinds of funny things.  Please
> > revert to the old method until you have a common pci_driver for fbdev and dri.
> 
> fbdev and DRI are not functional together in the general case. They
> sometimes happen to work by luck. fbdev and X for that matter are
> generally incompatible except unaccelerated.

Works fine on all my pmacs here.  In fact X works only on fbdev for
full features.

