Return-Path: <linux-kernel-owner+w=401wt.eu-S1750906AbXAICFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbXAICFs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbXAICFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:05:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:57175 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbXAICFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:05:47 -0500
Subject: Re: Linux 2.6.20-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@suse.de>
Cc: Sylvain Munaut <tnt@246tNt.com>,
       Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linuxppc-dev@ozlabs.org,
       Linus Torvalds <torvalds@osdl.org>, paulus@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20070109005624.GA598@suse.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <200701081550.27748.m.kozlowski@tuxland.pl> <45A25C17.5070606@246tNt.com>
	 <1168303139.22458.246.camel@localhost.localdomain>
	 <20070109005624.GA598@suse.de>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 13:05:23 +1100
Message-Id: <1168308323.22458.254.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 16:56 -0800, Greg KH wrote:
> On Tue, Jan 09, 2007 at 11:38:59AM +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2007-01-08 at 15:58 +0100, Sylvain Munaut wrote:
> > > Don't build ohci as module for now.
> > > A fix for that is already in gregkh usb tree for 2.6.21
> > 
> > Do you mean that as-is, powerpc defconfigs cannot build USB as a module
> > in 2.6.20 ? That is unacceptable as a regression. We need a fix in
> > 2.6.20.
> > 
> > Greg, what is the status there ?
> 
> Hm, for some reason I thought your patches were not needed until 2.6.21.

My endian patches aren't, but Sylvain' are based on mines so ... Maybe
if Sylvain rebases his ?

> Should I forward them on to Linus now for 2.6.20?  Are they required for
> ppc to build?

Sylvain fixes are. My endian patches are for ps3 and toshiba celleb,
none of which is fully merged in 2.6.20 so they are fine to wait. It's
mostly a matter of being a PITA to rebase Sylvain stuff to apply before
mine and rebase mine on top of his I suppose :-)

Ben.

