Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbTIJAOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 20:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbTIJAOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 20:14:31 -0400
Received: from adsl-153-88-46.bct.bellsouth.net ([68.153.88.46]:14416 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id S265081AbTIJAO3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 20:14:29 -0400
Date: Tue, 9 Sep 2003 20:27:20 -0400
To: linux-kernel@vger.kernel.org
Subject: usb_control/bulk_msg: timeout / NETDEV WATCHDOG: eth0: transmit timed out
Message-ID: <20030910002720.GA30861@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Anybody know what's up with this?  Running 2.4.23-pre3 I get the following 
while booting up:

usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e601.
  diagnostics: net 0cc0 media 88c0 dma 0000003b.
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 16(0) current 16(0)
  Transmit list 00000000 vs. c15eb200.
  0: @c15eb200  length 8000002a status 0000002a
  1: @c15eb240  length 8000002a status 0000002a
  2: @c15eb280  length 8000002a status 0000002a
  3: @c15eb2c0  length 8000002a status 0000002a
  4: @c15eb300  length 8000002a status 0000002a
  5: @c15eb340  length 8000002a status 0000002a
  6: @c15eb380  length 8000002a status 0000002a
  7: @c15eb3c0  length 8000002a status 0000002a
  8: @c15eb400  length 8000002a status 0000002a
  9: @c15eb440  length 8000002a status 0000002a
  10: @c15eb480  length 8000002a status 0000002a
  11: @c15eb4c0  length 8000002a status 0000002a
  12: @c15eb500  length 8000002a status 0000002a
  13: @c15eb540  length 8000002a status 0000002a
  14: @c15eb580  length 8000002a status 8000002a
  15: @c15eb5c0  length 8000002a status 8000002a
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e601.
  diagnostics: net 0cc0 media 88c0 dma 0000003b.
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 32(0) current 32(0)
  Transmit list 00000000 vs. c15eb200.
  0: @c15eb200  length 8000002a status 0000002a
  1: @c15eb240  length 8000002a status 0000002a
  2: @c15eb280  length 8000002a status 0000002a
  3: @c15eb2c0  length 80000049 status 00000049
  4: @c15eb300  length 80000049 status 00000049
  5: @c15eb340  length 80000049 status 00000049
  6: @c15eb380  length 80000049 status 00000049
  7: @c15eb3c0  length 80000049 status 00000049
  8: @c15eb400  length 80000049 status 00000049
  9: @c15eb440  length 80000049 status 00000049
  10: @c15eb480  length 80000049 status 00000049
  11: @c15eb4c0  length 80000049 status 00000049
  12: @c15eb500  length 8000004c status 0000004c
  13: @c15eb540  length 8000004c status 0000004c
  14: @c15eb580  length 8000004c status 8000004c
  15: @c15eb5c0  length 8000004c status 8000004c
eth0: Resetting the Tx ring pointer.

..
..


-- 
L1:	khromy		;khromy (at) lnuxlab.ath.cx
