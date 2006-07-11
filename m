Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWGKXW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWGKXW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWGKXW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:22:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:5544 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932232AbWGKXW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:22:56 -0400
Date: Tue, 11 Jul 2006 16:00:55 -0700
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, akpm@osdl.org,
       mingo@redhat.com, Reuben Farrelly <reuben-lkml@reub.net>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.18-rc1-mm1
Message-ID: <20060711230055.GL18838@kroah.com>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF9C0@hdsmsx411.amr.corp.intel.com> <1152521329.4874.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152521329.4874.3.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 10:48:49AM +0200, Arjan van de Ven wrote:
> On Sun, 2006-07-09 at 13:47 -0400, Brown, Len wrote:
> > >> 2. Onto some more minor warnings:
> > >> 
> > >> ACPI: bus type pci registered
> > >> PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> > >> PCI: Not using MMCONFIG.
> > >> PCI: Using configuration type 1
> > >> ACPI: Interpreter enabled
> > >> 
> > >> Is there any way to verify that there really is a BIOS bug 
> > >there?  If it is, is there anyone within Intel or are there any
> > >known contacts 
> > >who can push and poke > to get this looked at/fixed?
> > >(It's a new Intel board, I'd hope they could get it right..).
> > 
> > Arjan should probably comment on that one.
> 
> I could.. but please next time if you want to CC me use an email address
> I actually read ;)
> 
> Greg has a patch to relax this check, and Rajesh has a further patch to
> relax it more.

Hm, no, my patch should already be in 2.6.18-rc1, I don't have any
pending MMCONFIG patches in my queue or tree.

So if you think I'm missing one, please resend it to me.

thanks,

greg k-h
