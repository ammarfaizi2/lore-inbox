Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266176AbUHSOBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUHSOBy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUHSOBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:01:54 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:2436 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266176AbUHSOBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:01:51 -0400
Date: Thu, 19 Aug 2004 16:01:52 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040819140152.GB12634@ucw.cz>
References: <20040814221010.GA18592@ucw.cz> <20040818181310.12047.qmail@web14927.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818181310.12047.qmail@web14927.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I haven't received any comments on pci-sysfs-rom-17.patch. Is everyone
> asleep or is it ready to be pushed upstream? I'm still not sure that
> anyone has tried it on a ppc machine.

I was away, so sorry for the delay.  The patch looks OK to me now.

I was thinking again about the VGA ROM's and I tend to believe that even if
you happen to guess correctly where is the ROM shadowed, it would be better
to show the _original_ ROM image and deliver the shadow copy as a separate
file. (If somebody decides to initialize the VGA manually by running the
code in the ROM, is the shadow copy any better?)

I think that we can apply the current version of the patch (maybe except the
shadowing logic) and think about these issues later.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"In theory, practice and theory are the same, but in practice they are different." -- Larry McVoy
