Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbTKLTHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 14:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTKLTG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 14:06:59 -0500
Received: from uu90.internetdsl.tpnet.pl ([80.55.150.90]:52997 "EHLO
	zachod.com") by vger.kernel.org with ESMTP id S264141AbTKLTG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 14:06:58 -0500
From: Bartlomiej Pater <nostah@gazeta.pl>
To: linux-kernel@vger.kernel.org
Subject: problems with usb storage and nforce2 board
Date: Wed, 12 Nov 2003 20:06:52 +0100
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200311122006.52088.nostah@gazeta.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have recently changed mainboard for SIS735-based to nForce2-based (asus
a7n8x-x if that matters). Since then I've been experiencing problems using
my datafab KCCF-USBG CF reader. It means it does not work at all - it is
detected by kernel but mounting the partition causes lock of the mount
process and timeout messages until the reader is unplugged.

The reader itself is functional - works with any other mainboard I have
access to, including USB2.0 one based on Intel 845G chipset. The mainboards
usb ports are also working as I've managed to configure my digital camera
to work. Both camera and CF reader are usb1.1 devices but turning BIOS into
USB 1.1 mode changes nothing.

I've tried all the latest kernels available including 2.4.23-rc1 and
2.6.0-test9 with no success. I know that Datafab devices are tricky and
often caused problems in the past, but is there anything that could make it
work? I don't have Windows at home so I couldn't test how it behaves on it. 

Because both syslog and kernel config are quite big files I've placed them on 
WWW. USB and USB-storage were compiled with full debug. Here are the URLs:

http://zachod.com/~noster/kernel-config
http://zachod.com/~noster/syslog-usb20

If there anything I could do to help in solving this thing I am ready :)

regards,
nst;
