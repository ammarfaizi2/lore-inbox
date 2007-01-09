Return-Path: <linux-kernel-owner+w=401wt.eu-S1751201AbXAIJHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbXAIJHE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbXAIJHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:07:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:59388 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbXAIJHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:07:01 -0500
Subject: Re: Linux 2.6.20-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg KH <gregkh@suse.de>, Sylvain Munaut <tnt@246tNt.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       paulus@samba.org
In-Reply-To: <1168326274.14763.313.camel@shinybook.infradead.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <200701081550.27748.m.kozlowski@tuxland.pl> <45A25C17.5070606@246tNt.com>
	 <1168303139.22458.246.camel@localhost.localdomain>
	 <20070109005624.GA598@suse.de>
	 <1168308323.22458.254.camel@localhost.localdomain>
	 <1168326274.14763.313.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 20:04:48 +1100
Message-Id: <1168333488.22458.263.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 15:04 +0800, David Woodhouse wrote:
> On Tue, 2007-01-09 at 13:05 +1100, Benjamin Herrenschmidt wrote:
> > Sylvain fixes are. My endian patches are for ps3 and toshiba celleb,
> > none of which is fully merged in 2.6.20 so they are fine to wait. It's
> > mostly a matter of being a PITA to rebase Sylvain stuff to apply before
> > mine and rebase mine on top of his I suppose :-) 
> 
> Er, doesn't Efika need the same endian patches?

No, Efika is fully big endian OHCI which is already supported. The
patches are for "split" endian OHCI and EHCI (the toshiba chip).

Ben.


