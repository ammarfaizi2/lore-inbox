Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVACNdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVACNdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVACNdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:33:09 -0500
Received: from users.linvision.com ([62.58.92.114]:1954 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261446AbVACNdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:33:03 -0500
Date: Mon, 3 Jan 2005 14:33:02 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: This time? Bug in Reiser4 or usb or hardware flaw?
Message-ID: <20050103133301.GD23288@harddisk-recovery.com>
References: <200501030329.16836@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501030329.16836@zodiac.zodiac.dnsalias.org>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 03:29:16AM +0100, Alexander Gran wrote:
> while copying larger amounts (15GB) of data from a ext2 to a reiser4 partition 
> on a usb hdd, everything failed and I had to reboot. Dunno if its reiser4 or 
> usb thats failing here, though. The kernel was not going to see the external 
> hdd again.
> Heres dmesg output:

[...]

> I had to use sysrq to reboot, reboot would just hang as would lsusb.
> USB enviroment is an ICH-4 ehci, one hub and an icy-box. uhci drivers not 
> compiled.

I expect it to be a USB 2.0 problem, not a reiser4 problem. I've seen
this kind of behavior when trying to copy data to an ext3 filesystem on
an USB 2.0 IDE converter. If you use the drive with a USB 1.1 host
controller, it will probably succeed. I haven't yet figured out if it
is a usb-storage problem or a hardware problem (in the USB IDE
converter).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
