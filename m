Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284928AbRLKIA0>; Tue, 11 Dec 2001 03:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284927AbRLKIAH>; Tue, 11 Dec 2001 03:00:07 -0500
Received: from [202.54.26.202] ([202.54.26.202]:9351 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S284926AbRLKH7y>;
	Tue, 11 Dec 2001 02:59:54 -0500
X-Lotus-FromDomain: HSS
From: gspujar@hss.hns.com
To: linux-kernel@vger.kernel.org
cc: achowdhry@hss.hns.com
Message-ID: <65256B1F.002BF453.00@sandesh.hss.hns.com>
Date: Tue, 11 Dec 2001 13:33:04 +0530
Subject: software watchdog
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi all,

I am using software watchdog in my application.  When the watchdog reboots the
system,

>>>printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n"); prints the message
on the console.

I put a delay of 5secs with mdelay, and I can see the message on the console.
I wanted the message as a syslog,

so I added         kern.crit in /etc/syslog.conf file.,
But I am not getting the above message in the log file.
Can any one help me with this ????

Thanks
Girish


