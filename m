Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267280AbSKPOls>; Sat, 16 Nov 2002 09:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbSKPOls>; Sat, 16 Nov 2002 09:41:48 -0500
Received: from host194.steeleye.com ([66.206.164.34]:13586 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267280AbSKPOlr>; Sat, 16 Nov 2002 09:41:47 -0500
Message-Id: <200211161448.gAGEmYl02479@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       grundler@dsl2.external.hp.com, willy@debian.org
Subject: Re: [RFC][PATCH] move dma_mask into struct device 
In-Reply-To: Message from Mike Anderson <andmike@us.ibm.com> 
   of "Fri, 15 Nov 2002 16:19:14 PST." <20021116001914.GA3153@beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Nov 2002 09:48:31 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andmike@us.ibm.com said:
> I got a compile error here. This should be.
> 	dev->dev.dma_mask = &dev->dma_mask; 

Oops, yes, that's what comes of making changes in code you don't compile.

> The machine is a 2x pci systems with the following drivers loaded:
> 	aic7xxx, ips, qlogicisp. 

Thanks for testing it.

James


