Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUEaEsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUEaEsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 00:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUEaEsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 00:48:22 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:33424 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264412AbUEaEsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 00:48:17 -0400
Message-ID: <40BAB8D9.2080705@blue-labs.org>
Date: Mon, 31 May 2004 00:47:21 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040412
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.7-rc1, 3com still broken after resume
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May 30 21:37:39 powerix PM: Preparing system for suspend
May 30 23:56:44 powerix Stopping tasks: 
=====================================================================|
May 30 23:56:44 powerix PM: Entering state.
May 30 23:56:44 powerix Back to C!
May 30 23:56:44 powerix PM: Finishing up.
May 30 23:56:44 powerix PCI: Setting latency timer of device 
0000:00:1d.0 to 64
May 30 23:56:44 powerix PCI: Setting latency timer of device 
0000:00:1d.0 to 64
May 30 23:56:44 powerix PCI: Setting latency timer of device 
0000:00:1d.2 to 64
May 30 23:56:44 powerix PCI: Setting latency timer of device 
0000:00:1d.2 to 64
May 30 23:56:44 powerix PCI: Setting latency timer of device 
0000:00:1f.5 to 64
May 30 23:56:44 powerix PCI: Setting latency timer of device 
0000:00:1f.6 to 64
May 30 23:56:44 powerix eth0: command 0x5800 did not complete! Status=0xffff
May 30 23:56:44 powerix eth0: command 0x2804 did not complete! Status=0xffff
May 30 23:56:44 powerix drivers/acpi/osl.c:737: 
spin_lock(drivers/acpi/osl.c:c170e620) already locked by drivers/acpi/osl.c
/737
May 30 23:56:44 powerix drivers/acpi/osl.c:756: 
spin_unlock(drivers/acpi/osl.c:c170e620) not locked
May 30 23:56:49 powerix Restarting tasks...<3>eth0: command 0x3002 did 
not complete! Status=0xffff
May 30 23:56:49 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:56:49 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:56:49 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:56:49 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:56:49 powerix done
May 30 23:56:49 powerix logger: ACPI group ac_adapter / action 
ac_adapter is not defined
May 30 23:56:49 powerix logger: ACPI group battery / action battery is 
not defined
May 30 23:56:49 powerix logger: ACPI group battery / action battery is 
not defined
May 30 23:56:49 powerix cardmgr[7087]: executing: './network suspend eth2'
May 30 23:56:50 powerix cardmgr[7087]: + SCHEME: smvfd
May 30 23:56:50 powerix cardmgr[7087]: + ADDRESS: 
smvfd,2,0,00:02:2D:5C:18:9F
May 30 23:56:50 powerix cardmgr[7087]: + NEW_SCHEME:
May 30 23:56:50 powerix cardmgr[7087]: + KEY: D0D7C12E8BEBAD5C9D19828DAB
May 30 23:56:50 powerix cardmgr[7087]: shutting down socket 0
May 30 23:56:50 powerix cardmgr[7087]: shutting down socket 1
May 30 23:56:50 powerix cardmgr[7087]: executing: './network resume eth2'
May 30 23:56:50 powerix cardmgr[7087]: + SCHEME: smvfd
May 30 23:56:50 powerix cardmgr[7087]: + ADDRESS: 
smvfd,2,0,00:02:2D:5C:18:9F
May 30 23:56:50 powerix cardmgr[7087]: + NEW_SCHEME:
May 30 23:56:50 powerix cardmgr[7087]: + KEY: D0D7C12E8BEBAD5C9D19828DAB
May 30 23:56:50 powerix cardmgr[7087]: + ./network: line 28: 
/etc/init.d/net.eth2: No such file or directory
May 30 23:56:50 powerix cardmgr[7087]: resume cmd exited with status 127
May 30 23:56:56 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:56:56 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:56:56 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:56:56 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:56:56 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:57:04 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:57:04 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:57:04 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:57:04 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:57:04 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:57:11 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:57:23 powerix NETDEV WATCHDOG: eth0: transmit timed out
May 30 23:57:23 powerix eth0: transmit timed out, tx_status ff status ffff.
May 30 23:57:23 powerix diagnostics: net ffff media ffff dma ffffffff 
fifo ffff
May 30 23:57:23 powerix eth0: Transmitter encountered 16 collisions -- 
network cable problem?
May 30 23:57:23 powerix eth0: Interrupt posted but not delivered -- IRQ 
blocked by another device?
May 30 23:57:23 powerix Flags; bus-master 1, dirty 0(0) current 16(0)
May 30 23:57:23 powerix Transmit list ffffffff vs. e74ed200.
May 30 23:57:23 powerix eth0: command 0x3002 did not complete! Status=0xffff
May 30 23:57:23 powerix 0: @e74ed200  length 8000002a status 0000002a
May 30 23:57:23 powerix 1: @e74ed2a0  length 8000002a status 0000002a
May 30 23:57:23 powerix 2: @e74ed340  length 8000002a status 0000002a
May 30 23:57:23 powerix 3: @e74ed3e0  length 8000002a status 0000002a
May 30 23:57:23 powerix 4: @e74ed480  length 8000004e status 0000004e
May 30 23:57:23 powerix 5: @e74ed520  length 8000002a status 0000002a
May 30 23:57:23 powerix 6: @e74ed5c0  length 8000002a status 0000002a
May 30 23:57:23 powerix 7: @e74ed660  length 8000002a status 0000002a
May 30 23:57:23 powerix 8: @e74ed700  length 8000002a status 0000002a
May 30 23:57:23 powerix 9: @e74ed7a0  length 8000004e status 0000004e
May 30 23:57:23 powerix 10: @e74ed840  length 8000002a status 0000002a
May 30 23:57:23 powerix 11: @e74ed8e0  length 8000002a status 0000002a
May 30 23:57:23 powerix 12: @e74ed980  length 8000002a status 0000002a
May 30 23:57:23 powerix 13: @e74eda20  length 8000002a status 0000002a
May 30 23:57:23 powerix 14: @e74edac0  length 8000004e status 8000004e
May 30 23:57:23 powerix 15: @e74edb60  length 8000002a status 8000002a
May 30 23:57:23 powerix eth0: command 0x5800 did not complete! Status=0xffff
May 30 23:57:23 powerix eth0: Resetting the Tx ring pointer.



The following chunk repeats every ~8 seconds forever after downing the 
interface.  After resume, this interface is useless.  Unfortunately this 
affects _everything_ for several seconds; harddrive, keyboard, mouse, 
screen updates, etc.  Some events are queued, some are lost.

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status ff status ffff.
  diagnostics: net ffff media ffff dma ffffffff fifo ffff
eth0: Transmitter encountered 16 collisions -- network cable problem?
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 0(0) current 16(0)
  Transmit list ffffffff vs. e74ed200.
eth0: command 0x3002 did not complete! Status=0xffff
  0: @e74ed200  length 8000024e status 0000024e
  1: @e74ed2a0  length 8000024e status 0000024e
  2: @e74ed340  length 8000024e status 0000024e
  3: @e74ed3e0  length 8000024e status 0000024e
  4: @e74ed480  length 8000024e status 0000024e
  5: @e74ed520  length 8000024e status 0000024e
  6: @e74ed5c0  length 8000024e status 0000024e
  7: @e74ed660  length 8000024e status 0000024e
  8: @e74ed700  length 8000024e status 0000024e
  9: @e74ed7a0  length 8000024e status 0000024e
  10: @e74ed840  length 8000024e status 0000024e
  11: @e74ed8e0  length 8000024e status 0000024e
  12: @e74ed980  length 8000024e status 0000024e
  13: @e74eda20  length 8000024e status 0000024e
  14: @e74edac0  length 8000024e status 8000024e
  15: @e74edb60  length 8000024e status 8000024e
eth0: command 0x5800 did not complete! Status=0xffff
eth0: Resetting the Tx ring pointer.

