Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTJIOGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTJIOGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:06:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61675 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262182AbTJIOF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:05:56 -0400
Date: Thu, 9 Oct 2003 16:05:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode
Message-ID: <20031009140547.GD1232@suse.de>
References: <200310091103.h99B31ug014566@hera.kernel.org> <3F856A7E.2010607@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F856A7E.2010607@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09 2003, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> >ChangeSet 1.1150.1.52, 2003/10/08 10:49:45-03:00, axboe@suse.de
> >
> >	[PATCH] laptop mode
> >	
> >	Hi Marcelo,
> >	
> >	Lots of people have been using this patch with great success, and 
> >	it's
> >	been in the SuSE kernel for some months now too. It is also in the 
> >	-benh
> >	ppc tree
> >	
> >	Basically, it introduces a write back mode of dirty and journal data
> >	that is more suitable for laptops. At the block layer end, it 
> >	schedules
> >	write out of dirty data after the disk has been idle for 5 seconds.
> >	
> >	Laptop mode can be switched on and off with /proc/sys/vm/laptop_mode.
> >	There is also a block_dump sysctl, which if enabled will dump who
> >	dirties and writes out data. This is very helpful in pinning down 
> >	who is
> >	causing unnecessary writes to the disk.
> 
> Red Hat just dropped this patch since it was suspected of data 
> corruption ;-(

Eh? Care to explain a bit further? I'm not aware of any data corruption
issues there, and it's certainly simple enough to easily audit.

And how kind of Red Hat to not inform me of any suspicion in this
regard.

-- 
Jens Axboe

