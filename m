Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWGKTmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWGKTmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWGKTmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:42:21 -0400
Received: from mail.suse.de ([195.135.220.2]:54450 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932100AbWGKTmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:42:20 -0400
Date: Tue, 11 Jul 2006 12:37:42 -0700
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Reuben Farrelly <reuben-lkml@reub.net>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-acpi@vger.kernel.org, rdunlap@xenotime.net, greg@kroah.com,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.18-rc1-mm1
Message-ID: <20060711193742.GD32146@suse.de>
References: <20060709021106.9310d4d1.akpm@osdl.org> <44B0E6E6.6070904@reub.net> <20060709052252.8c95202a.akpm@osdl.org> <20060709183538.GB88036@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709183538.GB88036@muc.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 08:35:38PM +0200, Andi Kleen wrote:
> On Sun, Jul 09, 2006 at 05:22:52AM -0700, Andrew Morton wrote:
> > > ACPI: bus type pci registered
> > > PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> > > PCI: Not using MMCONFIG.
> > > PCI: Using configuration type 1
> > > ACPI: Interpreter enabled
> > > 
> > > Is there any way to verify that there really is a BIOS bug there?  If it is, is 
> > > there anyone within Intel or are there any known contacts who can push and poke 
> > > to get this looked at/fixed?  (It's a new Intel board, I'd hope they could get 
> > > it right..).
> > > 
> > > Plus we're not using MMCONFIG - even though I have it enabled.
> > 
> > Andi stuff.
> 
> Greg has patches to relax the checking a bit. 
> 
> I don't know when he intends to merge them.

I think they are all merged into 2.6.18-rc1, as I do't see any MMCONFIG
patches in my tree right now, nor in my queue.

thanks,

greg k-h
