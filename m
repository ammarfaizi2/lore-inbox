Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbUKWCGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUKWCGW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUKWCGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:06:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:9163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262514AbUKWCAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:00:50 -0500
Date: Mon, 22 Nov 2004 18:00:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Len Brown <len.brown@intel.com>,
       Chris Wright <chrisw@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
Message-ID: <20041122180045.J2357@build.pdx.osdl.net>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de> <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>; from torvalds@osdl.org on Sat, Nov 20, 2004 at 10:28:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also for the record...

* Linus Torvalds (torvalds@osdl.org) wrote:
> So I think the simpler fix is just this one-liner: we should not disable
> preexisting links, because non-PCI devices may depend on the same routing
> information, and thus the comments about "being activated on use" is not
> actually true.

This boots as expected (no irq6 storm).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
