Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWHaS0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWHaS0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWHaS0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:26:00 -0400
Received: from mail.gmx.de ([213.165.64.20]:63360 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932439AbWHaSZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:25:59 -0400
X-Authenticated: #24096462
Date: Thu, 31 Aug 2006 20:26:21 +0200
From: Jan-Hendrik Zab <xaero@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Problem with USB storage devices, error -110
Message-ID: <20060831202621.1ae04865@localhost>
X-Mailer: Sylpheed-Claws 2.4.0cvs113 (GTK+ 2.10.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
any USB storage devices (like an external USB HDD) that I connect to
the USB PCI adaptor card fail to be 'recognized' correctly by the
kernel. The dmesg output looks like this:

usb 3-1: new full speed USB device using uhci_hcd and address 2
usb usb2: suspend_rh (auto-stop)
usb 3-1: ep0 maxpacket = 8
usb 3-1: khubd timed out on ep0in len=-8/18
usb 3-1: device descriptor read/all, error -110
usb 3-1: new full speed USB device using uhci_hcd and address 3
usb 3-1: khubd timed out on ep0in len=-8/64
usb 3-1: khubd timed out on ep0in len=-8/64
usb 3-1: khubd timed out on ep0in len=-8/64
usb 3-1: device descriptor read/64, error -110
usb 3-1: khubd timed out on ep0in len=-8/64
usb 3-1: khubd timed out on ep0in len=-8/64
usb 3-1: khubd timed out on ep0in len=-8/64
usb 3-1: device descriptor read/64, error -110
usb 3-1: new full speed USB device using uhci_hcd and address 4

I've also uploaded the complete dmesg output to:
http://v3ng34nce.org/dmesg_output.bz2

The computer where the problem appears is running kernel 2.6.18-rc5
now, after showing similar errors under the 'unstable' SMP Debian kernel
2.6.17-1-686.

Greets,
    Jan-Hendrik Zab

-- 
| Jan-Hendrik Zab
| +49 (0)1773392888
| http://www.v3ng34nce.org

