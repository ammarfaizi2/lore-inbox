Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTDWQux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbTDWQuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:50:52 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:4237 "EHLO lakemtao02.cox.net")
	by vger.kernel.org with ESMTP id S264137AbTDWQuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:50:51 -0400
Message-ID: <3EA6C732.2060504@cox.net>
Date: Wed, 23 Apr 2003 12:02:42 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-rc1] Zipdrive messages too much
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I included ppa and scsi in my kernel since I have a parallel port 
zipdrive. Problem I am having is that it keeps scanning the drive for 
too much too often. Anytime I mount/unmount, plug/unplug USB and 
firewire devices, or at random times, I get the following messages on my 
console and in my messages file.

Apr 23 11:41:35 aeon kernel: sda : READ CAPACITY failed.
Apr 23 11:41:35 aeon kernel: sda : status = 1, message = 00, host = 0, 
driver = 08
Apr 23 11:41:35 aeon kernel: Current sd00:00: sns = 70  2
Apr 23 11:41:35 aeon kernel: ASC=3a ASCQ= 0
Apr 23 11:41:35 aeon kernel: Raw sense data:0x70 0x00 0x02 0x00 0x00 
0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 
0xfe 0x01 0x00 0x00 0x00 0x00
Apr 23 11:41:35 aeon kernel: sda : block size assumed to be 512 bytes, 
disk size 1GB.
Apr 23 11:41:35 aeon kernel: sda: Write Protect is off
Apr 23 11:41:35 aeon kernel:  sda: I/O error: dev 08:00, sector 0
Apr 23 11:41:35 aeon kernel:  I/O error: dev 08:00, sector 0
Apr 23 11:41:35 aeon kernel:  unable to read partition table
Apr 23 11:41:35 aeon kernel: Device not ready.  Make sure there is a 
disc in the drive.

This gets really annoying, but I like to use my zipdrive.
Let me know if more information is needed.

Thanks,
David

