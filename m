Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSKMVfV>; Wed, 13 Nov 2002 16:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSKMVfV>; Wed, 13 Nov 2002 16:35:21 -0500
Received: from dsl2.external.hp.com ([192.25.206.7]:57350 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id <S262905AbSKMVfU>; Wed, 13 Nov 2002 16:35:20 -0500
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: Bjorn Helgaas <bjorn_helgaas@hp.com>, Greg KH <greg@kroah.com>,
       Miles Bader <miles@gnu.org>, Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface 
In-Reply-To: Message from "J.E.J. Bottomley" <James.Bottomley@steeleye.com> 
   of "Wed, 13 Nov 2002 15:44:17 EST." <200211132044.gADKiHi02548@localhost.localdomain> 
References: <200211132044.gADKiHi02548@localhost.localdomain> 
Date: Wed, 13 Nov 2002 14:42:15 -0700
From: Grant Grundler <grundler@dsl2.external.hp.com>
Message-Id: <20021113214215.AD0494829@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.E.J. Bottomley" wrote:
> However, I think the ultimate destination is to see how much of the bus 
> specific stuff we can abstract by throwing an API around it.  I think IRQ, 
> port and mmio are feasible.  Specific knowledge of bus posting et al may not 
> be.

I was thinking how many BARs are present/used is PCI specific.

arch code already handles most of the IRQ fixups anyway and it
doesn't really matter where IRQ info is stored as long as the
device driver knows where to find it.

> > Duck! (that's going to get fixed it seems) ;^) 
> 
> I thought the 53c700 was working OK?

sorry - "going to get fixed" meant we are looking for a C180
or similar machine to send you.

thanks!
grant
