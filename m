Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTJIOLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbTJIOLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:11:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33773 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262223AbTJIOLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:11:51 -0400
Date: Thu, 9 Oct 2003 16:11:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode
Message-ID: <20031009141143.GF1232@suse.de>
References: <3F856A7E.2010607@pobox.com> <Pine.LNX.4.44.0310091109010.3040-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310091109010.3040-100000@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09 2003, Marcelo Tosatti wrote:
> 
> 
> On Thu, 9 Oct 2003, Jeff Garzik wrote:
> 
> > Linux Kernel Mailing List wrote:
> > > ChangeSet 1.1150.1.52, 2003/10/08 10:49:45-03:00, axboe@suse.de
> > > 
> > > 	[PATCH] laptop mode
> > > 	
> > > 	Hi Marcelo,
> > > 	
> > > 	Lots of people have been using this patch with great success, and it's
> > > 	been in the SuSE kernel for some months now too. It is also in the -benh
> > > 	ppc tree
> > > 	
> > > 	Basically, it introduces a write back mode of dirty and journal data
> > > 	that is more suitable for laptops. At the block layer end, it schedules
> > > 	write out of dirty data after the disk has been idle for 5 seconds.
> > > 	
> > > 	Laptop mode can be switched on and off with /proc/sys/vm/laptop_mode.
> > > 	There is also a block_dump sysctl, which if enabled will dump who
> > > 	dirties and writes out data. This is very helpful in pinning down who is
> > > 	causing unnecessary writes to the disk.
> > 
> > Red Hat just dropped this patch since it was suspected of data 
> > corruption ;-(
> 
> Uh, oh... Jens? 

See my previous mail. I don't see any problems with it, and I've
certainly not heard of (or experienced myself) problems with the patch.
I'm waiting for Jeff to expand on his mail, surely he/RH must know more
about this issue.

-- 
Jens Axboe

