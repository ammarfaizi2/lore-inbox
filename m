Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbUKWAsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbUKWAsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbUKWAsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 19:48:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25351 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262456AbUKWAqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 19:46:25 -0500
Date: Tue, 23 Nov 2004 01:46:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Len Brown <len.brown@intel.com>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
Message-ID: <20041123004619.GQ19419@stusta.de>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de> <1101148138.20008.6.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101148138.20008.6.camel@d845pe>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 01:28:59PM -0500, Len Brown wrote:
>...
> > BTW: Is all what ACPI does really required, if all I need ACPI for is
> > to turn the power off after halting my computer?
> 
> On this system ACPI is required to configure the IOAPIC.
> 
> It may be possible to save power in idle with c-states
> and at run-time with p-states (cpufreq) on this box,
> but I couldn't tell that from the dmesg if CONFIG_ACPI_PROCESSOR
> was included or not.

It's not.

> If you don't care about interrupt performance and you don't
> mind pressing the power button when you halt the system,
> go ahead and run with CONFIG_ACPI=n.

Not needed "pressing the power button when you halt the system" is the 
"killer application" for using ACPI for me...

> cheers,
> -Len

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

