Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268794AbUH3TIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268794AbUH3TIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268772AbUH3TIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:08:41 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:26029 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268271AbUH3TF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:05:29 -0400
Subject: Re: HCI USB on USB 2.0: hci_usb_intr_rx_submit (works with USB 1.1)
From: "Raf D'Halleweyn (list)" <list@noduck.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1093068439.3544.2.camel@notepaq>
References: <1091581193.15561.3.camel@alto.dhalleweyn.com>
	 <1092049263.21815.18.camel@pegasus>
	 <1092966777.5230.4.camel@alto.dhalleweyn.com>
	 <1092990717.18082.60.camel@pegasus>  <1093014039.28268.10.camel@base>
	 <1093068439.3544.2.camel@notepaq>
Content-Type: text/plain
Date: Mon, 30 Aug 2004 15:05:27 -0400
Message-Id: <1093892727.8617.2.camel@alto.dhalleweyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcel,

I am sorry, I messed up: I have two D-Link dongles, I thought they were
the same. They are not!

I also seem to be having a problem with some of the my USB2.0 ports
(other devices act weird on it also). I will figure out those problems
first.

Thanks anyway!

Raf.

On Sat, 2004-08-21 at 08:07 +0200, Marcel Holtmann wrote:
> Hi Ralf,
> 
> > Okay, I had bluez-bluefw installed (Debian package) but it seems that
> > bluez now uses the standard firmware loading mechanism (request_firmware
> > ()). As such, I copied the BCM2033-FW.bin and BCM2033-MD.hex files from
> > that package into /usr/lib/hotplug/firmware and removed bluez-bluefw.
> > 
> > However, I cannot find any evidence of the firmware actually being
> > loaded. I believe that my hotplug install is correctly installed (it can
> > load the ipw2100 firmware). I added some debugging
> > to /etc/hotplug/firmware.agent, but couldn't find any evidence of any
> > firmware being requested for the dongle.
> > 
> > Any suggestions what I could try next? Should I add USB_DEVICE(0x0a12,
> > 0x0001) to the usb_device_id array in bcm203x.c?
> 
> this is getting weird, because 0a12:0001 is a CSR based dongle and not a
> Broadcom one. So firmware loading is not needed. It should simply work.
> Give 2.6.8 a try.
> 
> Regards
> 
> Marcel


