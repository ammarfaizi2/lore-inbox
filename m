Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269527AbUICRbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269527AbUICRbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269680AbUICRa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:30:26 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:25057 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269527AbUICR22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:28:28 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Fri, 3 Sep 2004 10:27:46 -0700
User-Agent: KMail/1.7
Cc: Greg KH <greg@kroah.com>, Matthew Wilcox <willy@debian.org>,
       Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20040903014048.60310.qmail@web14922.mail.yahoo.com>
In-Reply-To: <20040903014048.60310.qmail@web14922.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409031027.46354.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 2, 2004 6:40 pm, Jon Smirl wrote:
> This is a repost of the pci-sysfs-rom-22.patch. No one has made any
> comments on this version. All previous objections have been addressed.
> Any objections to sending it upstream?

Hm, the last one I tried worked fine, but this one makes my qla card stop 
working, but not right way.  The system gets to init and then falls over, 
maybe when it starts doing writes?  The last version I tried seems to work ok 
though.  Has something changed in the PCI layer that would affect this?

Thanks,
Jesse
