Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVCSPEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVCSPEc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 10:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVCSPEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 10:04:22 -0500
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:43482 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262571AbVCSPDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 10:03:54 -0500
Subject: bcm203x broadcom dongle firmware upload fails...
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 16:03:45 +0100
Message-Id: <1111244625.6115.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I don't see why, it used to work reliably at some point but now it does
not. It even won't work without hotplug and then manually typing:

echo 1 > /sys/class/firmware/2-1/loading
cat /lib/firmware/BCM2033-FW.bin >/sys/class/firmware/2-1/data
echo 0 > /sys/class/firmware/2-1/loading

usb 2-1: new full speed USB device using ohci_hcd and address 2
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
bcm203x_probe: Mini driver request failed
bcm203x: probe of 2-1:1.0 failed with error -5
usbcore: registered new driver bcm203x

It does not work with kernel 2.6.10/11 any ideas ?

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

