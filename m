Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUG3ThH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUG3ThH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267802AbUG3ThG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:37:06 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:16007 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S267809AbUG3Tf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:35:58 -0400
Date: Fri, 30 Jul 2004 21:35:59 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730193559.GA4687@ucw.cz>
References: <20040730190456.GZ10025@parcelfarce.linux.theplanet.co.uk> <20040730193011.5239.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730193011.5239.qmail@web14929.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Another idea, it's ok to read the ROM when there is no device driver
> loaded. When the driver for one of these card loads it could trigger a
> copy of the ROM into RAM and cache it in a PCI structure.

I really doubt it's worth the RAM wasted by the automatic caching of ROM's
which will be probably left unused in 99.9% of cases.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Never make any mistaeks.
