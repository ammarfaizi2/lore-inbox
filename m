Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbWJNLms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWJNLms (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 07:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWJNLms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 07:42:48 -0400
Received: from tux.linux.ee ([195.222.16.153]:28387 "EHLO tux.linux.ee")
	by vger.kernel.org with ESMTP id S1161114AbWJNLmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 07:42:47 -0400
Date: Sat, 14 Oct 2006 14:42:45 +0300
To: linux-kernel@vger.kernel.org
Subject: ppc prep boot hang in 2.6.19-rc2
Message-ID: <20061014114245.GA19056@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: mroos@linux.ee (Meelis Roos)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using Motorola Powerstack II Pro4000 (PReP). While 2.6.18 works
mostly fine on this machine (modulo iptables alignment fix that is
hand-applied), 2.6.19-rc1+git from 11. sept and 2.6.19/rc2 hang on boot
after detecting VGA console:

loaded at:     00400400 00569F4C
relocated to:  00800000 00969B4C
zimage at:     0080AE58 00960B02
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/sda3 tere tere tere
Uncompressing Linux...done.
Now booting the kernel
Total memory = 192MB; using 512kB for hash table (at c0380000)
Linux version 2.6.19-rc2 (mroos@muuseum) (gcc version 4.1.2 20061007 (prerelease) (Debian 4.1.1-16)) #38 Fri Oct 13 22:49:17 EEST 2006
PReP architecture
Zone PFN ranges:
  DMA             0 ->    49152
  Normal      49152 ->    49152
early_node_map[1] active PFN ranges
    0:        0 ->    49152
Built 1 zonelists.  Total pages: 48768
Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/sda3 tere tere tere
PID hash table entries: 1024 (order: 10, 4096 bytes)
time_init: decrementer frequency = 16.657582 MHz
Console: colour VGA+ 80x25

-- 
Meelis Roos <mroos@linux.ee>
