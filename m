Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267850AbRGZM3r>; Thu, 26 Jul 2001 08:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267859AbRGZM3h>; Thu, 26 Jul 2001 08:29:37 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:35773 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267850AbRGZM3T>; Thu, 26 Jul 2001 08:29:19 -0400
Date: Thu, 26 Jul 2001 08:29:25 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: john@vnet.ibm.com, LINUX-KERNEL@vger.kernel.org
Subject: Re: Reserving large amounts of RAM for busmastering PCI card.
Message-ID: <20010726082925.B2322@devserv.devel.redhat.com>
In-Reply-To: <mailman.996053899.5490.linux-kernel2news@redhat.com> <200107252200.f6PM0IJ01020@devserv.devel.redhat.com> <3B5F428F.14DCAA44@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B5F428F.14DCAA44@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Jul 25, 2001 at 06:05:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > >  Since the 2.4 kernels introduce the e820map structure, I'd like to
> > >  plug into that infrastructure, and create a new type memory segment
> > >  for this storage (I envisage having more than one segment), but in the
> > >  2.4.4 kernel (which I am forced to remain with for quite a while) it
> > >  seems not to be used apart from set up at boot time.
> > 
> > Stop reinventing the wheel and take Matt & Pauline's bigphisarea.
> >  http://www.polyware.nl/~middelink/patch/bigphysarea-2.4.4.tar.gz
> 
> Is bigphysarea needed in 2.4?   You have alloc_bootmem...

I thought bigphisarea allowed to unload and reload modules,
at least I used it that way with C-cube MPEG board. Makes
for faster tests.

-- Pete
