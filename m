Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbUJaU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUJaU1K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 15:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUJaU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 15:27:10 -0500
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:1176 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261360AbUJaU1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 15:27:06 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc1-mm2] Firmware loader gone bogus?
Date: Sun, 31 Oct 2004 16:27:01 -0500
User-Agent: KMail/1.7
Cc: ipw2100-devel@lists.sourceforge.net, smiler@lanil.mine.nu
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410311627.02116.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah I noticed my ipw2200 firmware broke in 2.6.10-rc1-bk5

Does 2.6.10-rc1 non-bk snapshots work for you? 

Shawn.

> List:       linux-kernel
> Subject:    [2.6.10-rc1-mm2] Firmware loader gone bogus?
> From:       Christian Axelsson <smiler () lanil ! mine ! nu>
> Date:       2004-10-31 19:51:28
> Message-ID: <41854240.3050909 () lanil ! mine ! nu>
> [Download message RAW]
> 
> Ive upgraded from 2.6.9-rc4-mm1 to 2.6.10-rc1-mm2 and now the firmware 
> loader seems broken. I have an internal wlan-adapter that runs the 
> ipw2200-driver and I get errors when trying to load the firmware.
> Then I tried my prism54-based card and got the following errors in dmesg:
> 
> Loaded prism54 driver, version 1.2
> PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
> ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 6 (level, low) -> IRQ 6
> eth1: resetting device...
> eth1: uploading firmware...
> prism54: request_firmware() failed for 'isl3890'
> eth1: could not upload firmware ('isl3890')
> eth1: islpci_reset: failure
> 
> The firmware files are in place and both these cards with drivers have 
> worked fine before. Config attached
> 
> -- 
> Regards,
> Christian
