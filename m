Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbTKNScQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 13:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264520AbTKNScQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 13:32:16 -0500
Received: from havoc.gtf.org ([63.247.75.124]:52870 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264519AbTKNScM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 13:32:12 -0500
Date: Fri, 14 Nov 2003 13:29:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Daniel Gryniewicz <dang@fprintf.net>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
Message-ID: <20031114182927.GA8810@gtf.org>
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au> <1068787304.4157.8.camel@localhost> <16308.26754.867801.131463@notabene.cse.unsw.edu.au> <20031114101647.GJ32211@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114101647.GJ32211@marowsky-bree.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 11:16:47AM +0100, Lars Marowsky-Bree wrote:
> On 2003-11-14T16:30:42,
>    Neil Brown <neilb@cse.unsw.edu.au> said:
> 
> > There are issues with the raid superblock but assuming they can be
> > solved, I want partitioning to work easily.
> > 
> > Can LVM work happily with 'legacy' partitioning information?
> 
> I'd really suggest to run DM (either LVM2 or EVMS2) on top of md
> instead. It's much more flexible; I don't see any benefit in 'old style'
> partition information, which has all sorts of problems - ie,
> non-transactional updates (_why_ were you running raid again? ;), static
> as they can't be modified during runtime etc.

This brings up a tangent point...  partitions on top of RAID are a new
thing, which means that one has the chance to define the partition
format.

And I kinda like EFI partition format, a lot better than the other
common ones...

	Jeff


P.S. No, this isn't a blanket endorsement of EFI as a whole :)
