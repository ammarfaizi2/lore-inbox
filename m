Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSEPNYU>; Thu, 16 May 2002 09:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSEPNYT>; Thu, 16 May 2002 09:24:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35598 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312590AbSEPNYS>; Thu, 16 May 2002 09:24:18 -0400
Subject: Re: your mail
To: sanket.rathi@cdac.ernet.in (Sanket Rathi)
Date: Thu, 16 May 2002 14:38:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10205161809140.1835-100000@mailhub.cdac.ernet.in> from "Sanket Rathi" at May 16, 2002 06:10:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178LSH-0004GU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just want to know how can we restrict the maximum virtual memory and
> maximum physical memory on ia64 platform.
> kernel. Actually we have a device which can only access 44 bits so we cant

That won't help you. You might not be dealing with RAM at the bottom of the
address space. You might also be in platforms with an iommu, or doing DMA
to another PCI target

> Tell me something related to this or any link which i can refer

Assuming the device is doing bus mastering. Read
Documentation/DMA-mapping.txt
