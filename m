Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUHFO7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUHFO7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268075AbUHFO7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:59:20 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:59843 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S265999AbUHFO7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:59:14 -0400
Message-ID: <41139D3F.9060705@verizon.net>
Date: Fri, 06 Aug 2004 11:01:19 -0400
From: Mike <turbanator1@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 DVD+R problems
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.202.92.151] at Fri, 6 Aug 2004 09:59:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My kernel version (was) 2.6.7, but is now 2.6.8rc3. This is a sample of 
the errors I see when trying to mount a DVD or CD:

7>ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 96
Buffer I/O error on device sr0, logical block 12
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 104
Buffer I/O error on device sr0, logical block 13
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 112
Buffer I/O error on device sr0, logical block 14
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 120
Buffer I/O error on device sr0, logical block 15
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
7>ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 96
Buffer I/O error on device sr0, logical block 12
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 104
Buffer I/O error on device sr0, logical block 13
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 112
Buffer I/O error on device sr0, logical block 14
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 120
Buffer I/O error on device sr0, logical block 15
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep0out 3strikes
ehci_hcd 0000:00:0b.2: devpath 4 ep2in 3strikes

Yes, I can confirm that this drive works on a Gateway laptop running 
Windows 2000.

When trying to mount this drive, I do:

mount /dev/sr0 /mnt/cdrom

