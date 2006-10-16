Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWJPUwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWJPUwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWJPUwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:52:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57052 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161062AbWJPUwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:52:03 -0400
Subject: Re: [PATCH] pci: x86-32/64 switch to pci_get API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061016190115.GA45331@muc.de>
References: <1161013892.24237.100.camel@localhost.localdomain>
	 <20061016160759.GA14354@muc.de>
	 <1161017113.24237.115.camel@localhost.localdomain>
	 <20061016162426.GB14354@muc.de>
	 <1161018340.24237.122.camel@localhost.localdomain>
	 <20061016190115.GA45331@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 22:18:45 +0100
Message-Id: <1161033525.24237.128.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 21:01 +0200, ysgrifennodd Andi Kleen:
> Ok i applied the patch to -rc2, but it results in 
> 
> arch/x86_64/pci/built-in.o: In function `pcibios_irq_init':
> irq.c:(.init.text+0xc7e): undefined reference to `pci_get_bus_and_slot'
> 
> That function is also nowhere to be found:

I was just cc'ing you on a set of patches for -mm which included this
one and the other neccessary PCI changes. Sorry for any confusion.

