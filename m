Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbVIZRaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbVIZRaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbVIZRaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:30:06 -0400
Received: from s1.ckr-solutions.com ([82.97.10.19]:52945 "EHLO
	s1.ckr-solutions.com") by vger.kernel.org with ESMTP
	id S1751697AbVIZRaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:30:05 -0400
Date: Mon, 26 Sep 2005 19:32:03 +0200 (CEST)
From: Olivier Kaloudoff <kalou@kalou.net>
X-X-Sender: kalou@s1.ckr-solutions.com
To: linux-kernel@vger.kernel.org
Subject: watchdog with P4SCI and 2.6.9 (Supermicro)
Message-ID: <Pine.LNX.4.62.0509261920340.15689@s1.ckr-solutions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !


 	I'm happy to say that watchdog for P4SCi is detected
fine with my 2.6.9-freevps-1.5-1 kernel (centos 4.1 patched with freevps 
1.5-1)

[root@shinwey ~]# uname -a
Linux shinwey 2.6.9-freevps-1.5-1 #1 SMP Sun Sep 25 23:07:51 CEST 2005 
i686 i686 i386 GNU/Linux


Sep 26 10:55:18 shinwey kernel: WDT500/501-P driver 0.10 at 0x0240 
(Interrupt 11). heartbeat=60 sec (nowayout=0)

Sep 26 10:55:18 shinwey kernel: wdt: Fan Tachometer is Disabled
Sep 26 10:55:18 shinwey kernel: w83877f_wdt: cannot register miscdev on minor=130 (err=-16)

Sep 26 10:55:18 shinwey kernel: WDT driver for the Winbond(TM) W83627HF Super I/O chip 
initialising.

Sep 26 10:55:18 shinwey kernel: w83627hf WDT: cannot register miscdev on minor=130 (err=-16)


Unfortunatelly, I set up a 4 minutes delay in the bios, the server takes 
less than 2 minutes to boot and detect the watchdog chip, but reboot takes
place ...

I don't get what's happening, my /dev/watchdog is existing and conform to 
the devices.txt;

[root@shinwey Documentation]# ls -l /dev/watchdog
crw-------  1 root root 10, 130 Sep 26  2005 /dev/watchdog


Any tip ?



Sincere Regards,


Olivier Kaloudoff

