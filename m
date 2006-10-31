Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423841AbWJaUM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423841AbWJaUM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423838AbWJaUM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:12:27 -0500
Received: from ns1.suse.de ([195.135.220.2]:6060 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423565AbWJaUMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:12:25 -0500
Date: Tue, 31 Oct 2006 12:11:11 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Chua <jeff.chua.linux@gmail.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net, ak@suse.de, discuss@x86-64.org,
       Martin Lorenz <martin@lorenz.eu.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Hugh Dickins <hugh@veritas.com>, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org,
       Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>, Christian <christiand59@web.de>,
       davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk,
       Komuro <komurojun-mbn@nifty.com>, Thomas Gleixner <tglx@linutronix.de>,
       Randy Dunlap <randy.dunlap@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
       David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.19-rc4: known unfixed regressions
Message-ID: <20061031201111.GA17260@suse.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061031195654.GV27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031195654.GV27968@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 08:56:54PM +0100, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
> that are not yet fixed in Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> 
> 
> Subject    : PCI: MMCONFIG breakage
> References : http://lkml.org/lkml/2006/10/27/251
> Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
> Status     : unknown, both BIOS and Direct work

This seems to be now fixed by using the proper pci config accesses.

thanks,

greg k-h
