Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270640AbTG0Ag1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 20:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270641AbTG0Ag1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 20:36:27 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:64522 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270640AbTG0Ag0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 20:36:26 -0400
From: Marino Fernandez <mjferna@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.0 wont let me unmount eth0 upon reboot
Date: Sat, 26 Jul 2003 19:51:39 -0500
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307261951.40050.mjferna@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've trying the new kernel. Everything is OK, except that when I shut down my 
machine, I get this message:

unmounting remote filesystems
unregistering_netdevice: waiting for eth0 to become free. usage count = -4

This last line keeps repeating ad infinitum, until I turn the power down...

Needless to say that with 2.4.21 I don't have this problem.

I have a Fujitsu Lifebook C-7651 laptop, pentium III. My ethernet card is a 
Realtek 8129. I have this in my kernel config file:

# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set

8139too loads, I can get in the internet through my cable modem. If I do rmmod 
8139too I get the same message... I cannot unload the 8139too module.

Any help will be appreciated.

