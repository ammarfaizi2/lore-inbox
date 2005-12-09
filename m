Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVLIL3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVLIL3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVLIL3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:29:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16409 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750737AbVLIL3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:29:42 -0500
Date: Fri, 9 Dec 2005 12:30:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Erik Slagter <erik@slagter.name>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       Jeff Garzik <jgarzik@pobox.com>, hch@infradead.org, mjg59@srcf.ucam.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051209113053.GG26185@suse.de>
References: <20051208132657.GA21529@srcf.ucam.org> <20051208133308.GA13267@infradead.org> <20051208133945.GA21633@srcf.ucam.org> <20051208134438.GA13507@infradead.org> <1134062330.1732.9.camel@localhost.localdomain> <43989B00.5040503@pobox.com> <20051208133144.0f39cb37.randy_d_dunlap@linux.intel.com> <1134121522.27633.7.camel@localhost.localdomain> <20051209103937.GE26185@suse.de> <1134125145.27633.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134125145.27633.32.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09 2005, Erik Slagter wrote:
> On Fri, 2005-12-09 at 11:39 +0100, Jens Axboe wrote:
> 
> > > IMHO available infrastructure (and hardware abstraction!) should be used
> > > instead of being stubborn and pretend we know everything about any
> > > hardware.
> > 
> > It's not about being stubborn, it's about maintaining and working on a
> > clean design. The developers have to do that, not the users. So forgive
> > people for being a little cautious about shuffling all sorts of ACPI
> > into the scsi core and/or drivers. We always need to think long term
> > here.
> > 
> > Users don't care about the maintainability and cleanliness of the code,
> > they really just want it to work. Which is perfectly understandable.
> 
> I perfectly understand that, what I do object against, is rejecting a
> concept (like this) totally because the developers(?) do not like the
> mechanism that's used (although ACPI is used everywhere else in the
> kernel). At least there might be some discussion where this sort of code
> belongs to make the design clean and easily maintainable, instead of
> instantly completely rejecting the concept, because OP simply doesn't
> like acpi.

Not to put words in anyones mouth, but the rejection is mainly based on
the concept of stuffing acpi directly into the SCSI core where it
clearly doesn't belong. I don't think anyone is against utilizing ACPI
(if useful/required) for suspend+resume as a concept, even if lots of
people have reservations on ACPI in generel.

-- 
Jens Axboe

