Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136370AbRD2VIW>; Sun, 29 Apr 2001 17:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136369AbRD2VIM>; Sun, 29 Apr 2001 17:08:12 -0400
Received: from Host4.modempool1.milfordcable.net ([206.72.42.4]:2308 "HELO
	windeath.2y.net") by vger.kernel.org with SMTP id <S131886AbRD2VHy>;
	Sun, 29 Apr 2001 17:07:54 -0400
Message-ID: <3AEC83F2.DE6596F2@windeath.2y.net>
Date: Sun, 29 Apr 2001 16:13:22 -0500
From: James M <dart@windeath.2y.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Not just RealTek 8139/dhcpcd..epic100 broken also
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.2(working) 2.4.4(broken), Xeon 2-way SMP 400 mhz, 128 mem,
gcc 2.95.3, DHCP Client Daemon v.1.3, Mandrake 7.2
 
2.4.4 is broken with my epic100/dhcpcd....2.4.2 works fine. I copied
/lib/module/2.4.2../epic100.o to /lib/modules/2.4.4/../epic100.o with no
success.

Messages error: Apr 29 15:44:24 windeath kernel: eth0: Transmit timeout
using MII device, Tx status 0003.

Followed by more of the same except with status 000b. Unlike the realtek
errors a network stop/start/restart doesn't help. Looking at the patch
for 2.4.4 shows one tiny change to epic100. 

-- 

James M.
aka "Dart"
