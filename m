Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265677AbUADOMI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 09:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbUADOMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 09:12:08 -0500
Received: from [24.35.117.106] ([24.35.117.106]:10628 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265677AbUADOME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 09:12:04 -0500
Date: Sun, 4 Jan 2004 09:11:52 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: debug messages in 2.6.1-rc1-mm1
Message-ID: <Pine.LNX.4.58.0401040853000.11783@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following on my laptop while it is just sitting doing 
nothing.  The connect/disconnect lines are from my wireless pcmcia card.  
I'm not sure why I get so many of these messages.  My laptop is sitting 
within five feet of the WAP, so there should'nt be any of these messages.  
Also, they always used to go to /var/log/messages when they did happen.  I 
have no idea where the debug message came from.

eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
 00 00 <8b> 80 88 00 00 00 89 45 c0 b8 00 e0 ff ff 21 e0 ff 48 14 8b 40
 <6>note: pidof[1819] exited with preempt_count 1
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c0125d8b>] __might_sleep+0xab/0xd0
 [<c012b353>] profile_exit_task+0x23/0x60
 [<c012d849>] do_exit+0x79/0x9f0
[root@lap linux-2.6.0]# eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)



	

