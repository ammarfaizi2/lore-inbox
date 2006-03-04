Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWCDQcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWCDQcr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 11:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWCDQcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 11:32:47 -0500
Received: from mail.humboldt.co.uk ([80.68.93.146]:6924 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S932099AbWCDQcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 11:32:47 -0500
Subject: Re: Linux running on a PCI Option device?
From: Adrian Cox <adrian@humboldt.co.uk>
To: Jon Ringle <jringle@vertical.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200603031331.16849.jringle@vertical.com>
References: <43EAE4AC.6070807@snapgear.com>
	 <200603030909.28640.jringle@vertical.com>
	 <1141396843.8912.49.camel@localhost.localdomain>
	 <200603031331.16849.jringle@vertical.com>
Content-Type: text/plain
Date: Sat, 04 Mar 2006 16:32:27 +0000
Message-Id: <1141489948.9197.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 13:31 -0500, Jon Ringle wrote:
> On Friday 03 March 2006 09:40 am, Adrian Cox wrote:
> > Based on only a quick look at the code: if the Windows host is present,
> > don't call pci_common_init() in ixdp425_pci_init().
> 
> Doing this will prevent the code in ixp4xx_pci_preinit() from executing which 
> handles some initialization for both PCI host and option modes. Should I go 
> ahead and explicitly call ixp4xx_pci_preinit() from ixdp425_pci_init() if in 
> PCI option mode?

At this point I have to give up - I'm not an ixp4xx expert. While I have
developed a PCI option device under Linux, it was a PowerPC with a PLX
bridge and some custom logic.

-- 
Adrian Cox <adrian@humboldt.co.uk>

