Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUHCVg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUHCVg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUHCVg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:36:57 -0400
Received: from web14930.mail.yahoo.com ([216.136.225.159]:57214 "HELO
	web14930.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266887AbUHCVgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:36:25 -0400
Message-ID: <20040803213624.46232.qmail@web14930.mail.yahoo.com>
Date: Tue, 3 Aug 2004 14:36:24 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Martin Mares <mj@ucw.cz>, Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Jon Smirl <jonsmirl@yahoo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040803213121.GA4410@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lspci -b would be great but it doesn't seem to have implemented dumping
the ROM location. It dumps everything else.

--- Martin Mares <mj@ucw.cz> wrote:

> > Yeah, it doesn't look like they've been properly assigned
> addresses.  But then 
> > I've also seen lspci lie, you can check /sys/devices/.../config for
> the 
> > actual resource values.  If they're sane then things are more
> likely to work.
> 
> ... or try `lspci -b', it will dump the actual registers, not the
> kernel's
> view.
> 
> 				Have a nice fortnight
> -- 
> Martin `MJ' Mares   <mj@ucw.cz>  
> http://atrey.karlin.mff.cuni.cz/~mj/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep.,
> Earth
> A jury consists of 12 persons chosen to decide who has the better
> lawyer.
> 


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
