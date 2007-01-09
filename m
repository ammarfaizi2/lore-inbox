Return-Path: <linux-kernel-owner+w=401wt.eu-S1751129AbXAIHTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbXAIHTj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 02:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbXAIHTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 02:19:39 -0500
Received: from ns2.suse.de ([195.135.220.15]:56170 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbXAIHTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 02:19:39 -0500
Date: Mon, 8 Jan 2007 23:18:47 -0800
From: Greg KH <gregkh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sylvain Munaut <tnt@246tNt.com>,
       Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linuxppc-dev@ozlabs.org,
       Linus Torvalds <torvalds@osdl.org>, paulus@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc4
Message-ID: <20070109071847.GC6013@suse.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <200701081550.27748.m.kozlowski@tuxland.pl> <45A25C17.5070606@246tNt.com> <1168303139.22458.246.camel@localhost.localdomain> <20070109005624.GA598@suse.de> <1168308323.22458.254.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168308323.22458.254.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 01:05:23PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2007-01-08 at 16:56 -0800, Greg KH wrote:
> > On Tue, Jan 09, 2007 at 11:38:59AM +1100, Benjamin Herrenschmidt wrote:
> > > On Mon, 2007-01-08 at 15:58 +0100, Sylvain Munaut wrote:
> > > > Don't build ohci as module for now.
> > > > A fix for that is already in gregkh usb tree for 2.6.21
> > > 
> > > Do you mean that as-is, powerpc defconfigs cannot build USB as a module
> > > in 2.6.20 ? That is unacceptable as a regression. We need a fix in
> > > 2.6.20.
> > > 
> > > Greg, what is the status there ?
> > 
> > Hm, for some reason I thought your patches were not needed until 2.6.21.
> 
> My endian patches aren't, but Sylvain' are based on mines so ... Maybe
> if Sylvain rebases his ?

Yes, if something needs to get in now, please let me know, I don't have
any USB patches pending in the "2.6.20" queue at this moment.

thanks,

greg k-h
