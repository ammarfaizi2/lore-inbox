Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbULVAlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbULVAlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbULVAlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:41:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:37547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261924AbULVAlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:41:40 -0500
Date: Tue, 21 Dec 2004 16:41:27 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041222004127.GA13112@kroah.com>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz> <20041217220208.GA22752@kroah.com> <20041218000920.GE29084@elf.ucw.cz> <20041221200401.GB9577@kroah.com> <20041221233742.GC1218@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221233742.GC1218@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 12:37:43AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > Alright, I've applied this, and it will show up in the next -mm release.
> > > > I also fixed up pci.h for when CONFIG_PCI=N due to your changed
> > > > functions.
> > > > 
> > > > Now, care to send patches to fix up all of the new sparse warnings in
> > > > the drivers/pci/* directory?
> > > 
> > > This should fix warnings in drivers/net/* and bttv (with exception of
> > > via-rhine, which I'll do separately). Do you think you could apply it,
> > > or shall I ask Andrew, or... ?
> > > 
> > > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > 
> > What kernel tree is this against?  I get lots of rejects against the
> > latest -bk tree.
> 
> It was against 2.6.9. pci_{save,restore}_state(), therefore it rejects
> in surrounding text. Here's version against latest -bk.
> 
> This should fix sparse warnings in drivers/net/* and bttv. Please
> apply,

Applied, thanks.

greg k-h
