Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161257AbWI2Qux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbWI2Qux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWI2Qux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:50:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56547 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932366AbWI2Quw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:50:52 -0400
Subject: Re: 2.6.18-mm2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: "J.A. Magall??n" <jamagallon@ono.com>, Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <20060929143949.GL5017@parisc-linux.org>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 18:15:42 +0100
Message-Id: <1159550143.13029.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-29 am 08:39 -0600, ysgrifennodd Matthew Wilcox:
> On Fri, Sep 29, 2006 at 03:57:38PM +0200, J.A. Magall??n wrote:
> > aic7xxx oopses on boot:
> > 
> > PCI: Setting latency timer of device 0000:00:0e.0 to 64
> > IRQ handler type mismatch for IRQ 0
> 
> Of course, this isn't a scsi problem, it's a peecee hardware problem.
> Or maybe a PCI subsystem problem.  But it's clearly not aic7xxx's fault.

AIC7xxx finding it has no IRQ configured is valid (annoying, stupid and
valid) so the driver should check before requesting "no IRQ"

