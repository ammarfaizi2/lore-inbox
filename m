Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSKMUFN>; Wed, 13 Nov 2002 15:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSKMUFN>; Wed, 13 Nov 2002 15:05:13 -0500
Received: from dsl2.external.hp.com ([192.25.206.7]:18187 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id <S262620AbSKMUFM>; Wed, 13 Nov 2002 15:05:12 -0500
To: Greg KH <greg@kroah.com>
Cc: Miles Bader <miles@gnu.org>,
       "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Tue, 12 Nov 2002 23:52:23 PST." <20021113075223.GZ2106@kroah.com> 
References: <20021109060342.GA7798@kroah.com> <200211091533.gA9FXuW02017@localhost.localdomain> <20021113061310.GD2106@kroah.com> <buon0odsyh9.fsf@mcspd15.ucom.lsi.nec.co.jp>  <20021113075223.GZ2106@kroah.com> 
Date: Wed, 13 Nov 2002 13:12:07 -0700
From: Grant Grundler <grundler@dsl2.external.hp.com>
Message-Id: <20021113201207.4F49C4829@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Are there any existing archs that need more than just dma_mask moved to
> struct device out of pci_dev?  Hm, ppc might need a bit more...

"out of pci_dev" and into struct device?
I think that's all parisc port would need now.

At some point I'd like to propose "dma_hint" field.
But I don't have a specific proposal yet.
Something to help drivers communicate DMA characteristics to
the IOMMU support code. ie bandwidth needed, cacheline line aware,
MWLI support, etc.

grant
