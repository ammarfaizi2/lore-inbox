Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130208AbRCCBKR>; Fri, 2 Mar 2001 20:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130209AbRCCBKI>; Fri, 2 Mar 2001 20:10:08 -0500
Received: from web4203.mail.yahoo.com ([216.115.104.136]:13575 "HELO
	web4203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130208AbRCCBKC>; Fri, 2 Mar 2001 20:10:02 -0500
Message-ID: <20010303011000.1832.qmail@web4203.mail.yahoo.com>
Date: Fri, 2 Mar 2001 17:10:00 -0800 (PST)
From: Jeremy <prrthd25@yahoo.com>
Subject: VFS: Cannot open root device
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
 HELP, I have a new server that I am trying to put
Redhat 7.0 on. It is a Compaq Proliant ML530 Dual PIII
1Ghz with a Gig of RAM. It has a Compaq smart array
5300 in it also. It boots just fine with the default
Redhat 7 kernel 2.2.16smp but when I compiled my own
2.4.2 kernel I get the following message.

request_module[scsi_host_adapter]: Root FS not mounted
request_module[scsi_host_adapter]: Root FS not mounted

Then some standard lines Then:

NET 4: Unix domain sockets 1.0/SMP for Linux NET 4.0
request_module[block-major-104]: Root FS not mounted
VFS: Cannot open root device "6802" or 68:02
Please append a correct "root=" boot option
Kernel Panic: VFS: Unable to mount root FS on 68:02

 When I boot 2.2.16 the only modules that are loaded
are cciss, NCR53C8XX, eepro100 and tlan. I have triple
checked and I have built cciss and NCR53C8XX into the
kernel, I even tried them as modules. It almost looks
like it just isn't loading the NCR53C8XX and then it
cant mount the File system.
 If you need any more info please let me know.

Please CC anything to me directly since I am not on
the mailing list.

Thanks,
   Jeremy

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
