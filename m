Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSEPP4L>; Thu, 16 May 2002 11:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSEPP4L>; Thu, 16 May 2002 11:56:11 -0400
Received: from mailx.cdacindia.com ([202.54.40.35]:60337 "EHLO
	falcon.cdac.ernet.in") by vger.kernel.org with ESMTP
	id <S313416AbSEPP4K>; Thu, 16 May 2002 11:56:10 -0400
Date: Thu, 16 May 2002 21:24:10 +0530 (IST)
From: Sanket Rathi <sanket.rathi@cdac.ernet.in>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Sanket Rathi <sanket.rathi@cdac.ernet.in>, linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <E178LSH-0004GU-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.10.10205162118380.10635-100000@mailhub.cdac.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No actually i don't want that for DMA it is for diffrent requirment.
actually in our device there is a page table in device which have
virtual to physical address translation we save virtual address in device
and corresponding physical address. but we can store only upto 44 bit 
information of virtual address thats why i want that.

Can you help me in this 

Thanks in advance

-----
--------Sanket


> > I just want to know how can we restrict the maximum virtual memory and
> > maximum physical memory on ia64 platform.
> > kernel. Actually we have a device which can only access 44 bits so we cant
> 
> That won't help you. You might not be dealing with RAM at the bottom of the
> address space. You might also be in platforms with an iommu, or doing DMA
> to another PCI target
> 
> > Tell me something related to this or any link which i can refer
> 
> Assuming the device is doing bus mastering. Read
> Documentation/DMA-mapping.txt
> 

