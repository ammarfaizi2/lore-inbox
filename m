Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTJIOHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTJIOHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:07:37 -0400
Received: from intra.cyclades.com ([64.186.161.6]:56707 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262197AbTJIOGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:06:36 -0400
Date: Thu, 9 Oct 2003 11:09:35 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Jeff Garzik <jgarzik@pobox.com>
Cc: marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] laptop mode
In-Reply-To: <3F856A7E.2010607@pobox.com>
Message-ID: <Pine.LNX.4.44.0310091109010.3040-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Oct 2003, Jeff Garzik wrote:

> Linux Kernel Mailing List wrote:
> > ChangeSet 1.1150.1.52, 2003/10/08 10:49:45-03:00, axboe@suse.de
> > 
> > 	[PATCH] laptop mode
> > 	
> > 	Hi Marcelo,
> > 	
> > 	Lots of people have been using this patch with great success, and it's
> > 	been in the SuSE kernel for some months now too. It is also in the -benh
> > 	ppc tree
> > 	
> > 	Basically, it introduces a write back mode of dirty and journal data
> > 	that is more suitable for laptops. At the block layer end, it schedules
> > 	write out of dirty data after the disk has been idle for 5 seconds.
> > 	
> > 	Laptop mode can be switched on and off with /proc/sys/vm/laptop_mode.
> > 	There is also a block_dump sysctl, which if enabled will dump who
> > 	dirties and writes out data. This is very helpful in pinning down who is
> > 	causing unnecessary writes to the disk.
> 
> Red Hat just dropped this patch since it was suspected of data 
> corruption ;-(

Uh, oh... Jens? 

