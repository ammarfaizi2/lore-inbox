Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVBDWLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVBDWLK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbVBDWHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:07:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48787 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264076AbVBDV4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:56:40 -0500
Date: Fri, 4 Feb 2005 21:56:20 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: Jon Smirl <jonsmirl@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [RFC] Reliable video POSTing on resume
In-Reply-To: <200502041010.13220.jbarnes@engr.sgi.com>
Message-ID: <Pine.LNX.4.56.0502042153420.26459@pentafluge.infradead.org>
References: <20050122134205.GA9354@wsc-gmbh.de> <20050204163019.GC1290@elf.ucw.cz>
 <9e4733910502040931955f5a6@mail.gmail.com> <200502041010.13220.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Jon does your emulator sit on top of the new legacy I/O and memory APIs?  I 
> added them for this very reason, though atm only ia64 supports them.  There's 
> documentation in Documentation/filesystems/sysfs-pci.txt if you want to take 
> a look.  On kernels that support it, sysfs can be a one stop shop for all 
> your gfx programming needs, since it provides access to the rom, PCI 
> resources (i.e. MMIO ranges, fb memory, etc.) and legacy I/O ports and 
> memory.

Thanks for the info. Actually the is what /sys/bus/graphics is for. I'm 
working on some patchs to migrate the fbdev subsystem to using it.

