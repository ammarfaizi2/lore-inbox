Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbTIRVOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 17:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbTIRVOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 17:14:37 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:52911 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262141AbTIRVOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 17:14:36 -0400
From: tomepperly@comcast.net
To: linux-kernel@vger.kernel.org
Subject: Trouble with Cisco Aironet 350 PCMCIA in 2.4.21 & 2.4.22
Date: Thu, 18 Sep 2003 21:14:34 +0000
X-Mailer: AT&T Message Center Version 1 (Sep 12 2003)
X-Authenticated-Sender: dG9tZXBwZXJseUBjb21jYXN0Lm5ldA==
Message-Id: <S262141AbTIRVOg/20030918211436Z+13414@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Aironet 350 PCMCIA card works fine with 2.4.20 and hasn't worked with vanilla
2.4.21  or 2.4.22 (with Debian patches). I've got a Dell Latitude with a 1.2GHz
mobile P3.

Here is what appears in my /var/log/syslog when I plug the card into the laptop.
Sep 18 13:35:56 driftcreek cardmgr[510]: initializing socket 1
Sep 18 13:35:57 driftcreek kernel: cs: memory probe 0x0c0000-0x0fffff: excluding
0xc0000-0xcffff 0xe0000-0xfffff
Sep 18 13:35:57 driftcreek cardmgr[510]: socket 1: 350 Series Wireless LAN Adapter
Sep 18 13:35:57 driftcreek cardmgr[510]:   product info: "Cisco Systems", "350
Series Wireless LAN Adapter"
Sep 18 13:35:57 driftcreek cardmgr[510]:   manfid: 0x015f, 0x000a  function: 6
(network)
Sep 18 13:35:57 driftcreek cardmgr[510]: executing: 'modprobe airo_cs'
Sep 18 13:35:57 driftcreek kernel: airo:  Probing for PCI adapters
Sep 18 13:35:57 driftcreek kernel: airo:  Finished probing for PCI adapters
Sep 18 13:35:57 driftcreek kernel: airo: register interrupt 0 failed, rc -16
Sep 18 13:35:57 driftcreek kernel: airo_cs: RequestConfiguration: Operation
succeeded
Sep 18 13:35:58 driftcreek cardmgr[510]: get dev info on socket 1 failed:
Resource temporarily unavailable

At this point, the system ignores the keyboard. Otherwise, the system is
responsive to my USB mouse and X11 continues responding.

Tom
