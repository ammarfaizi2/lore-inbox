Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVLIVNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVLIVNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVLIVNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:13:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24844 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932399AbVLIVNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:13:54 -0500
Date: Fri, 9 Dec 2005 22:13:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-usb-devel@lists.sourceforge.net, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: usblp suspend failure with 2.6.15-rc5
Message-ID: <20051209211351.GF23349@stusta.de>
References: <438F3A2F.5090207@gmx.net> <4395DE67.4050101@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4395DE67.4050101@gmx.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 07:54:31PM +0100, Carl-Daniel Hailfinger wrote:

> Hi,

Hi Carl-Daniel,

> since I switched to 2.6.15-rc2-git6, my machine is not able to suspend
> anymore if my USB printer is plugged in. The problem is reproducible.
> 
> usb 1-2: new full speed USB device using uhci_hcd and address 3
> drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 
> 0 proto 2 vid 0x04E8 pid 0x3242
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> PM: Preparing system for mem sleep
> Stopping tasks: ==================================================|
> usblp 1-2:1.0: no suspend?
> Could not suspend device 1-2: error -16
> Some devices failed to suspend
> Restarting tasks... done
> 
> 
> Earlier kernels (2.6.14.2 and before) worked just fine.
> 
> A first search suggests this problem was introduced between
> 2.6.14 and 2.6.15-rc2-git6. Should I try to narrow it down further?

yes, that would be good.

In this case, it would also help if you'd open a bug at 
bugzilla.kernel.org.

> Regards,
> Carl-Daniel

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

