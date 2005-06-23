Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVFWWup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVFWWup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVFWWup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:50:45 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39604 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262766AbVFWWuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:50:39 -0400
Subject: Re: PATCH: IDE - sensible probing for PCI systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl>
	 <1119363150.3325.151.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl>
	 <1119379587.3325.182.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119566026.18655.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Jun 2005 23:48:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-06-23 at 19:22, Maciej W. Rozycki wrote:
>  Besides, does a modern i386 really require them?  DOS compatibility is no 
> longer an issue for commodity hardware and the ISA bridge is gone.

Untrue on both counts

> Apparently the only legacy device still not replaced by anything else is 
> the RTC, which is rather surprising as there seems to be a lot of 
> reasonable alternatives for I2C available these days and i386 boxes have 
> had I2C for quite a while now.

DMA controller, floppy controller, keyboard, serial, mouse, parallel,
some video ports, random other objects on the lpc bus, miscellaneous
motherboard gunge.

>  Both IDE and video are distinct PCI devices these days, so there is no 
> need for them to hide their decoded address ranges.  I've thought that has 
> been sorted out.

We still support older machines that are pre PCI even. Most PC systems
also have ranges of non-PCI decoded space that appears in no PCI bar.

Alan

