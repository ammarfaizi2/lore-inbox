Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUHFWfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUHFWfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268321AbUHFWfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:35:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10903 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268310AbUHFWfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:35:22 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Fri, 6 Aug 2004 15:33:37 -0700
User-Agent: KMail/1.6.2
Cc: Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20040806211413.77833.qmail@web14926.mail.yahoo.com>
In-Reply-To: <20040806211413.77833.qmail@web14926.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408061533.37034.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 6, 2004 2:14 pm, Jon Smirl wrote:
> attributes after pcibios_init() then I can put the alloc call back.

I've fixed (well, hacked) the sn2 code such that your original check for 
res->parent will work correctly for me too, so it sounds like we're covered 
there.

> Please check the code out and give it some testing. It will probably
> needs some adjustment for other platforms.

Thanks, will do (though probably not until next week, I'm about to head out 
for the weekend).

Thanks,
Jesse
