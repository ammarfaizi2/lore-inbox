Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267809AbUG3TkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267809AbUG3TkC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267803AbUG3TkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:40:02 -0400
Received: from web14923.mail.yahoo.com ([216.136.225.7]:50270 "HELO
	web14923.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267809AbUG3Tjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:39:39 -0400
Message-ID: <20040730193932.20813.qmail@web14923.mail.yahoo.com>
Date: Fri, 30 Jul 2004 12:39:32 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Martin Mares <mj@ucw.cz>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20040730193559.GA4687@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Martin Mares <mj@ucw.cz> wrote:
> > Another idea, it's ok to read the ROM when there is no device
> driver
> > loaded. When the driver for one of these card loads it could
> trigger a
> > copy of the ROM into RAM and cache it in a PCI structure.
> 
> I really doubt it's worth the RAM wasted by the automatic caching of
> ROM's
> which will be probably left unused in 99.9% of cases.

The caching is only going to happen for cards with minimal address
decoder implementations. As far as I know there is only one card that
does this.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Take Yahoo! Mail with you! Get it on your mobile phone.
http://mobile.yahoo.com/maildemo 
