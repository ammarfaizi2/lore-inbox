Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUHCVct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUHCVct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUHCVb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:31:26 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:6020 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266870AbUHCVbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:31:20 -0400
Date: Tue, 3 Aug 2004 23:31:21 +0200
From: Martin Mares <mj@ucw.cz>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Jon Smirl <jonsmirl@yahoo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040803213121.GA4410@ucw.cz>
References: <20040803211948.59456.qmail@web14921.mail.yahoo.com> <200408031428.25853.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408031428.25853.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, it doesn't look like they've been properly assigned addresses.  But then 
> I've also seen lspci lie, you can check /sys/devices/.../config for the 
> actual resource values.  If they're sane then things are more likely to work.

... or try `lspci -b', it will dump the actual registers, not the kernel's
view.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A jury consists of 12 persons chosen to decide who has the better lawyer.
