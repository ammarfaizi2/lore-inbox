Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262777AbSJGU1A>; Mon, 7 Oct 2002 16:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262775AbSJGU01>; Mon, 7 Oct 2002 16:26:27 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:35131 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262764AbSJGUZO>; Mon, 7 Oct 2002 16:25:14 -0400
Date: Mon, 7 Oct 2002 16:32:26 -0400
From: Doug Ledford <dledford@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bart@etpmod.phys.tue.nl, jbinpg@shaw.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: initio driver needs updating
Message-ID: <20021007203226.GC15884@redhat.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	bart@etpmod.phys.tue.nl, jbinpg@shaw.ca,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210071110.g97BA1J18387@gum09.etpnet.phys.tue.nl> <1034000282.25098.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034000282.25098.21.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 03:18:02PM +0100, Alan Cox wrote:
> On Mon, 2002-10-07 at 12:09, bart@etpmod.phys.tue.nl wrote:
> > Yeah, found the same problem. I am not the maintainer, but more than
> > willing to take a shot at it. It has been a while since I rooted around
> > in the kernel source, and, more importantly, I would like to use my
> > CD-burner with 2.5 :-).
> 
> Good luck. The main thing it needs to do is use the pci mapping
> interfaces (see Documentation/DMA-mapping.txt). That actually has
> helpers for scsi stuff.

I did one of the initio drivers, someone else can look at my changes and 
see how to do the other initio driver.  They need some real help to be 
decent :-/

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
