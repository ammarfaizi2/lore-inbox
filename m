Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWGISfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWGISfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 14:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWGISfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 14:35:40 -0400
Received: from colin.muc.de ([193.149.48.1]:11012 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932378AbWGISfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 14:35:39 -0400
Date: 9 Jul 2006 20:35:38 +0200
Date: Sun, 9 Jul 2006 20:35:38 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org,
       rdunlap@xenotime.net, greg@kroah.com, john stultz <johnstul@us.ibm.com>,
       gregkh@suse.de
Subject: Re: 2.6.18-rc1-mm1
Message-ID: <20060709183538.GB88036@muc.de>
References: <20060709021106.9310d4d1.akpm@osdl.org> <44B0E6E6.6070904@reub.net> <20060709052252.8c95202a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709052252.8c95202a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 05:22:52AM -0700, Andrew Morton wrote:
> > ACPI: bus type pci registered
> > PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> > PCI: Not using MMCONFIG.
> > PCI: Using configuration type 1
> > ACPI: Interpreter enabled
> > 
> > Is there any way to verify that there really is a BIOS bug there?  If it is, is 
> > there anyone within Intel or are there any known contacts who can push and poke 
> > to get this looked at/fixed?  (It's a new Intel board, I'd hope they could get 
> > it right..).
> > 
> > Plus we're not using MMCONFIG - even though I have it enabled.
> 
> Andi stuff.

Greg has patches to relax the checking a bit. 

I don't know when he intends to merge them.

Anyways it should be completely harmless - mmconfig does nothing
essential right now.

-Andi
