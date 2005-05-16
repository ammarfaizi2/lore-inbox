Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVEPO6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVEPO6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVEPO62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:58:28 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:51167 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261683AbVEPO4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:56:23 -0400
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050516111859.GB13387@merlin.emma.line.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <20050515145241.GA5627@irc.pl>
	 <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
	 <200505151121.36243.gene.heskett@verizon.net>
	 <Pine.LNX.4.58.0505151809240.26531@artax.karlin.mff.cuni.cz>
	 <20050516111859.GB13387@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116255270.21358.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 May 2005 15:54:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have heard rumors about this, but all OEM manuals I looked at for
> drives I bought or recommended simply stated that the block currently
> being written at power loss can become damaged (with write cache off),
> and that the drive can lose the full write cache at power loss (with
> write cache on) so this looks like daydreaming manifested as rumor.

IBM drives definitely used to trash the sector in this case. They newer
ones either don't or recover from it presumably because people took that
to be a drive failure and returned it. Sometimes the people win ;)

> flashes its cache to NVRAM, or uses rotational energy to save its cache
> on the platters, please name brand and model and where I can download
> the material that documents this behavior.

I am not aware of any IDE drive with these properties.
