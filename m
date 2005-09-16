Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVIPVuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVIPVuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVIPVuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:50:04 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:59298 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1750710AbVIPVuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:50:01 -0400
Date: Fri, 16 Sep 2005 23:49:48 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mmap(2)ping of pci_alloc_consistent() allocated buffers on 2.4
 kernels question/help
In-Reply-To: <20050916214632.GA13136@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.60.0509162348510.14757@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0509162009510.14084@kepler.fjfi.cvut.cz>
 <1126896652.3103.10.camel@localhost.localdomain>
 <Pine.LNX.4.60.0509162302310.14757@kepler.fjfi.cvut.cz>
 <20050916214632.GA13136@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Sep 2005, Arjan van de Ven wrote:

> 
> On Fri, Sep 16, 2005 at 11:24:08PM +0200, Martin Drab wrote:
> > 
> > And would that help anyhow?
> 
> yes it would
> 
> > (obtained via the RT FIFO) that he wants to mmap, the ioctl mmaps it to 
> > the app., app. uses the data, and then calls another ioctl to unmap the 
> > buffer and release it for next filling.
> 
> don't use ioctls for this; the driver can just provide an mmap method and
> you can map this pci alloc'd ram straight into the userspace app... 

OK, will do. Thaks.

Martin

