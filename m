Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUAVSYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266298AbUAVSYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:24:40 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:46516 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266294AbUAVSYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:24:33 -0500
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@colin2.muc.de>
Cc: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, torvalds@osdl.org, greg@kroah.com,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
In-Reply-To: <20040122131258.GA84577@colin2.muc.de>
References: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
	 <20040122131258.GA84577@colin2.muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1074795663.1413.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 22 Jan 2004 18:21:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-01-22 at 13:12, Andi Kleen wrote:
> > +#ifdef CONFIG_PCI_EXPRESS
> > +	else if (!strcmp(str, "no_pcie")) {
> 
> Would "no_pciexp" be better? no_pcie looks nearly like a typo.

Other "nofoo" generally don't use "_" (Linux kernel really needs an
actual policy document for such stuff tho)

