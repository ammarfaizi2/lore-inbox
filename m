Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVGaRnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVGaRnX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 13:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVGaRnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 13:43:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59565 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261804AbVGaRnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 13:43:22 -0400
Date: Sun, 31 Jul 2005 10:42:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.13-rc4-mm1
Message-Id: <20050731104214.5c0e686c.akpm@osdl.org>
In-Reply-To: <42ECEA30.5060204@gmail.com>
References: <20050731020552.72623ad4.akpm@osdl.org>
	<42ECEA30.5060204@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(cc linux-usb-devel)

Michael Thonke <iogl64nx@gmail.com> wrote:
>
> Hello Andrew,
> 
> the ACPI bug or the problems with 2.6.13-rc3-mm[2,3] gone.
> The system boots now noiseless, except on problem with USB.
> 
> If my Prolific USB-Serialadapter  plugged in on reboot
> the ehci_hcd driver complains about a Hand-off bug in Bios.
> 
> -> snip
> 
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> 
> ehci_hcd 0000:00:1d.7: debug port 1
> 
> ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 01010001)
> 
> ehci_hcd 0000:00:1d.7: continuing after BIOS bug...
> 
> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
> 
> ehci_hcd 0000:00:1d.7: irq 161, io mem 0xd2dffc00
> 
> -> snip
> 
> 
> I wonder about this because all other USB devices working without this 
> message on boot.
> 
> USB Mouse,Keyboard and USB Storage and all mixed from USB 1.1 and 2.
> 
> When I rebooted without plugged Prolific Adapter and plug them in the 
> same port
> the kernel prints this message.
> 
> ->snip
> 
> usb 4-1: new full speed USB device using uhci_hcd and address 2
> 
> pl2303 4-1:1.0: PL-2303 converter detected
> 
> usb 4-1: PL-2303 converter now attached to ttyUSB0
> 
> -> snip
> 
> 
> Any Ideas what could be wrong here?

Nope.  Can you identify the most recent kernel which didn't have these
problems?
