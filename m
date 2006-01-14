Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945906AbWANAno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945906AbWANAno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945922AbWANAnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:43:39 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50097 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1945906AbWANAn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:43:26 -0500
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601131724.42054.bjorn.helgaas@hp.com>
References: <20060104221627.GA26064@lists.us.dell.com>
	 <20060106172140.GB19605@lists.us.dell.com>
	 <20060106223932.GB9230@lists.us.dell.com>
	 <200601131724.42054.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Jan 2006 00:45:22 +0000
Message-Id: <1137199522.9161.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ugh.  I really hate this sort of sharing.  Could dmi_scan.c go in
> drivers/firmware/ or something instead?

Not unreasonable. The DMI standard for the tables isn't specifically an
x86 thing but drawn mostly from the management group stuff. The arch
specific stuff is whether you scan for a table or ask the EFIng firmware

