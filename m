Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129288AbRBPLSE>; Fri, 16 Feb 2001 06:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129322AbRBPLRz>; Fri, 16 Feb 2001 06:17:55 -0500
Received: from highland.isltd.insignia.com ([195.217.222.20]:47631 "EHLO
	highland.isltd.insignia.com") by vger.kernel.org with ESMTP
	id <S129288AbRBPLRq>; Fri, 16 Feb 2001 06:17:46 -0500
Message-ID: <3A8D0C92.7060AABE@insignia.com>
Date: Fri, 16 Feb 2001 11:18:42 +0000
From: Stephen Thomas <stephen.thomas@insignia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Tulip in 2.4.1-ac14 still poorly
Content-Type: multipart/mixed;
 boundary="------------A14F82F5DE3BF9448E9CA77F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A14F82F5DE3BF9448E9CA77F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On trying 2.4.1-ac13 I hit the tulip driver problems reported elsewhere,
and ac14 does not seem to fix the problem on my machine.  Attached is an
extract from my /var/log/messages.

Stephen Thomas
--------------A14F82F5DE3BF9448E9CA77F
Content-Type: text/plain; charset=us-ascii;
 name="messages-2.4.1-ac14"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages-2.4.1-ac14"

Feb 15 16:07:32 triumph kernel: Linux version 2.4.1-ac14 (root@triumph.isltd.insignia.com) (gcc version 2.95.2 19991024 (release)) #1 Thu Feb 15 15:53:08 GMT 2001 
[ ... ]
Feb 15 16:07:33 triumph kernel: Detected 400.915 MHz processor. 
[ ... ]
Feb 15 16:07:33 triumph kernel: Memory: 126652k/131008k available (1009k kernel code, 3968k reserved, 372k data, 188k init, 0k highmem) 
[ ... ]
Feb 15 16:07:35 triumph kernel: CPU: Intel Pentium II (Deschutes) stepping 01 
[ ... ]
Feb 15 16:07:39 triumph kernel: Linux Tulip driver version 0.9.13b (January 24, 2001) 
Feb 15 16:07:39 triumph kernel: PCI: Found IRQ 10 for device 00:10.0 
Feb 15 16:07:39 triumph kernel: eth0: Lite-On 82c168 PNIC rev 32 at 0xe400, 00:C0:F0:2C:2B:3A, IRQ 10. 
Feb 15 16:07:39 triumph kernel: eth0:  MII transceiver #1 config 3100 status 7829 advertising 01e1. 
[ ... ]
Feb 15 16:07:54 triumph amd[601]: vim:/ mounted fstype host on /.automount/vim/root
Feb 15 16:08:03 triumph ypbind[373]: unknown: RPC: Timed out  
Feb 15 16:08:06 triumph kernel: nfs: server vim not responding, still trying 
Feb 15 16:08:06 triumph last message repeated 2 times
Feb 15 16:08:07 triumph kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Feb 15 16:08:14 triumph PAM-securetty[741]: Couldn't open /etc/securetty
Feb 15 16:08:15 triumph kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Feb 15 16:08:19 triumph amd[601]: file server vim type nfs is down
Feb 15 16:08:23 triumph kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Feb 15 16:08:55 triumph last message repeated 4 times
Feb 15 16:08:57 triumph ypbind[373]: broadcast: RPC: Timed out. 
Feb 15 16:09:03 triumph kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Feb 15 16:09:35 triumph last message repeated 4 times
Feb 15 16:09:51 triumph last message repeated 2 times
Feb 15 16:09:55 triumph kernel: nfs: task 99 can't get a request slot 
Feb 15 16:09:59 triumph kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Feb 15 16:10:01 triumph ypbind[373]: broadcast: RPC: Timed out. 
Feb 15 16:10:07 triumph kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Feb 15 16:10:11 triumph PAM-securetty[772]: Couldn't open /etc/securetty
Feb 15 16:10:15 triumph kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Feb 15 16:10:47 triumph last message repeated 4 times

--------------A14F82F5DE3BF9448E9CA77F--

