Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVJSKw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVJSKw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 06:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVJSKw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 06:52:57 -0400
Received: from 204.4.76.83.cust.bluewin.ch ([83.76.4.204]:4150 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S964788AbVJSKw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 06:52:57 -0400
Date: Wed, 19 Oct 2005 12:52:39 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: 3c900 boot-time kernel commandline parameters in 2.4.25
Message-ID: <20051019105239.GA9858@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I tell Linux kernel 2.4.25 on boot-time kernel commandline to
switch my eth0
-----------------------------------------------------------------------
  Bus  1, device   3, function  0:
    Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang] (rev
0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
      I/O at 0xc000 [0xc03f].
-----------------------------------------------------------------------

to TP transceiver and 10/100 autonegotiation?

I looked into Documentation/00-INDEX and into kernel-parameters.txt and
found just 

"        ether=          [HW,NET] Ethernet cards parameters (irq,
                        base_io_addr, mem_start, mem_end, name.
                        (mem_start is often overloaded to mean something
                        different and driver-specific).
"

which neither doesn't answer my question neither point to any
documentation where my question could be answered.

CL<
