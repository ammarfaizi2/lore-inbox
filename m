Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTADSlW>; Sat, 4 Jan 2003 13:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTADSlW>; Sat, 4 Jan 2003 13:41:22 -0500
Received: from shell4.BAYAREA.NET ([209.128.82.1]:52228 "EHLO
	shell4.bayarea.net") by vger.kernel.org with ESMTP
	id <S261292AbTADSlV>; Sat, 4 Jan 2003 13:41:21 -0500
Message-ID: <3E172D5B.70402@bayarea.net>
Date: Sat, 04 Jan 2003 10:52:11 -0800
From: Randy Broman <rbroman@bayarea.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, rbroman@bayarea.net
Subject: RH73 Promise ATA/133 Install Problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a  Gigabyte GA-7VRXP motherboard which has an on-board Promise 20276
ATA133/RAID controller. I want to install RH73, on the two ATA133 drives 
connected
to the Promise controller. I've set up the motherboard BIOS with the 
Promise 20276
interfaces as ATA (not RAID), and I want to install on the two drives in 
a software
 RAID configuration.

If I start the standard RH73 install it does not identify the two drives 
connected
to the Promise interfaces. I tried installing with the RedHat "Supplemental
Drivers" disk/floppy, but it doesn't seem to have a driver for the 
Promise. I
tried installing with the Promise ATA/RAID drivers downloaded from their
site, but their drivers seem to support only the "hardware" RAID 
configuration,
not plain drives on which I would set up software RAID.

Anyone know of a solution? In general I believe there are Promise and/or
ATA133 drivers included in the kernel, and I could set up a custom drivers
disk with those to use in the install, but I don't know how to do that (if
that's the solution, instructions or pointers to a howto would be 
appreciated).
Or, there may be an easier way. Advice appreciated.

(BTW I've had enough problems with Promise "hardware" RAID in the past
that I prefer to avoid this. Subsequent to the initial install I will do 
a custom
kernel to support some other PCI hardware I want to use in the box, and I've
found that upgrading after installing on Promise hardware RAID can be
problematical. Given use of software RAID, I am interested in knowing
what's the best kernel version or patch to use for stability and 
performance).

Pls cc me direct as I'm not a list subscriber - Thanx, Randy





