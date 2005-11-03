Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbVKCPxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbVKCPxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbVKCPxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:53:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28856 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030355AbVKCPxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:53:04 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051103153017.GH28038@flint.arm.linux.org.uk>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
	 <1131033483.18848.71.camel@localhost.localdomain>
	 <20051103153017.GH28038@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Nov 2005 16:23:20 +0000
Message-Id: <1131035000.18848.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-03 at 15:30 +0000, Russell King wrote:
> Ok, I look forward to fiddling with libata on ARM. 8)
> 
> You mentioned that libata doesn't do SWDMA - does it do MWDMA and PIO?

Yes. MWDMA works well, PIO is pretty crap in the base -mm tree but much
improved in the devel trees. I've generally been running stuff pio
before adding the DMA code in fact.

