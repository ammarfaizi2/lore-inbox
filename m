Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUIISag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUIISag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUIISaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:30:15 -0400
Received: from mtl.rackplans.net ([65.39.167.249]:52622 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S266490AbUIIS20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:28:26 -0400
Date: Thu, 9 Sep 2004 14:28:25 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: via-rhine problems with ACPI
Message-ID: <Pine.LNX.4.58.0409091420350.19115@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


via-rhine.c:v1.10-LK1.1.19  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 5 for device 00:12.0
PCI: Sharing IRQ 5 with 00:10.0

The machine is a VIA Nehemiah CPU with:
    Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 116).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 32 bit memory at 0xea001000 [0xea0010ff].
  Bus  1, device   0, function  0:


NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 1003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.

And of course no network connectivity.. without ACPI it all just works.  I
should have this hardware for a few more weeks if anyone wants to diagnose
it further.

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
