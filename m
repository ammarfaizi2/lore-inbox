Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUHCCEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUHCCEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 22:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUHCCEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 22:04:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40897 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264960AbUHCCEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 22:04:50 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Mon, 2 Aug 2004 19:03:39 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
References: <20040730221528.2702.qmail@web14922.mail.yahoo.com> <200408021002.31117.jbarnes@engr.sgi.com> <1091489449.1669.14.camel@localhost.localdomain>
In-Reply-To: <1091489449.1669.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408021903.39273.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 2, 2004 4:30 pm, Alan Cox wrote:
> What guarantees the ROM already has an assigned PCI address ?

Presumably the PCI core.  If that's a bad assumption, then clearly this code 
won't work as is and will need additional checks/setup code.

Jesse
