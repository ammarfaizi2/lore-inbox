Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUFNVbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUFNVbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUFNVbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:31:24 -0400
Received: from mailadmin.WKU.EDU ([161.6.18.52]:48323 "EHLO mailadmin.wku.edu")
	by vger.kernel.org with ESMTP id S264430AbUFNVbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:31:13 -0400
From: "Bikram Assal" <bikram.assal@wku.edu>
Subject: eepro100 NIC driver. any bug ?
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro WebUser Interface v.4.1.8
Date: Mon, 14 Jun 2004 16:31:09 -0500
Message-ID: <web-68980662@mailadmin.wku.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you suggest ee100 over eepro100 driver for an INTEL NIC ?

Currently, we are using eepro100 driver on one of our servers that have INTEL NICs installed.

I have come across a situation three times when I had to reboot the server because it hanged and wouldn't respond and next time when I rebooted the server, I did not find any messages in the /var/log/messages file.

On one of these occasions, I could see errors saying, 


kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 12:56:24 kernel: eth1: Transmit timed out: status f048 0c00 at 1703794288/1703794348 command 200ca000.
Jun 2 12:57:06 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 12:57:06 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794348/1703794410 command 0001a000.
Jun 2 12:57:58 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 12:57:58 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794410/1703794471 command 0001a000.


I have read documentation on the net mentioning that eepro100 is a deprecated driver and isntead ee100 should be used.

I dont know if I should relate the other hangs on our server with the one when we had these "transmit timed out" errors  show up in the /var/log/messages file.

Please suggest me on this.

Thanks for your help.

- Bikram 
OCA ( Oracle Certified Associate )
Database Specialist, WKU
http://www.wku.edu/~bikram.assal/
