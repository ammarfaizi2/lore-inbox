Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTKVL6R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 06:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTKVL6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 06:58:17 -0500
Received: from imap.gmx.net ([213.165.64.20]:61656 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262283AbTKVL6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 06:58:15 -0500
X-Authenticated: #18350204
Subject: 2.6.0-test9 USB: ehci_hcd / usb-storage I/O error
From: Kleiner Hampel <kleiner_hampel@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069502440.851.16.camel@linux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 22 Nov 2003 13:00:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my usb-storage doesn't work with linux.

What i have:

Kernel 2.6.0-test9
USB 2.0 mobile disk

The problem:

trying to access this device after loading usb modules, dmesg shows the
following:

USB Mass Storage support registered.
SCSI device sda: 117231408 512-byte hdwr sectors (60022 MB)
sda: assuming drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0
id 0 lun 0
SCSI error : <0 0 0 0> return code = 0x6070000
end_request: I/O error, dev sda, sector 128
Buffer I/O error on device sda, logical block 16
Buffer I/O error on device sda, logical block 17
Buffer I/O error on device sda, logical block 18
Buffer I/O error on device sda, logical block 19
Buffer I/O error on device sda, logical block 20
Buffer I/O error on device sda, logical block 21
Buffer I/O error on device sda, logical block 22
...

The hardware *works* correctly, i tried in with win2k and this works
without problems.

I have another usb storage and this works correctly with kernel
2.6.0-test9!

Any ideas?
I have found this problem often in different mailing lists, but with no
solution.
Perhaps it is a bug.

regards,
hampel


