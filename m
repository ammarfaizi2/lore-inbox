Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRB0Se7>; Tue, 27 Feb 2001 13:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRB0Set>; Tue, 27 Feb 2001 13:34:49 -0500
Received: from law2-f210.hotmail.com ([216.32.181.210]:11282 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129737AbRB0Seb>;
	Tue, 27 Feb 2001 13:34:31 -0500
X-Originating-IP: [195.29.214.50]
From: "Zdravko Spoljar" <flirek@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: nfs_refresh_inode ?
Date: Tue, 27 Feb 2001 18:34:24 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW2-F2101vraQ4yvco00012ad0@hotmail.com>
X-OriginalArrivalTime: 27 Feb 2001 18:34:25.0074 (UTC) FILETIME=[E8DA1920:01C0A0EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
i'm running 2.2.19pre14+RAID+ide and get this message from kernel:

nfs_refresh_inode: inode number mismatch
expected (0x0ffffffff/0x0ffffffff), got (0x0002b0001/0x00005605)
                                                           ^^^^
marked numbers vary from message to message. i can triger this
by doing "make test;chmod 777 test" on some nfs mounted file sistem
some times repeated chmod generate more messages, sometimes are executed ok. 
i have feeling it happend more often when there is some cpu and net load.

linux nfs client is dual pentium II (266) on P2B-DS with 2
promise IDE cards, net card is smc (using realtek 8139 driver), ide and scsi 
disks are in RAID 5 setup.
nfs server is Apple Network server running AIX4.1.5
net conn is 100MB over Cisco switch

ah, there is one more thing. on boot when nfs get mounted i find in dmesg:
"nfs warning: mount version older than kernel"
WTF? :)

all this not happend on 2.2.17+RAID

any ideas patches, more info?

flirek

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

