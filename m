Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314471AbSEPRql>; Thu, 16 May 2002 13:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314484AbSEPRqk>; Thu, 16 May 2002 13:46:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31505 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314471AbSEPRqk>; Thu, 16 May 2002 13:46:40 -0400
Subject: Re: your mail
To: sanket.rathi@cdac.ernet.in (Sanket Rathi)
Date: Thu, 16 May 2002 19:05:43 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        sanket.rathi@cdac.ernet.in (Sanket Rathi),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10205162118380.10635-100000@mailhub.cdac.ernet.in> from "Sanket Rathi" at May 16, 2002 09:24:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178PdH-0004kE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No actually i don't want that for DMA it is for diffrent requirment.
> actually in our device there is a page table in device which have
> virtual to physical address translation we save virtual address in device
> and corresponding physical address. but we can store only upto 44 bit 
> information of virtual address thats why i want that.

Still read Documentation/DMA-mapping.txt

Whether its DMA or not you are going to need to keep the allocations below
44bits and thats what the DMA allocators do
