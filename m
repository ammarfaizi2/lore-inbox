Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSKRJbo>; Mon, 18 Nov 2002 04:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSKRJbo>; Mon, 18 Nov 2002 04:31:44 -0500
Received: from CPE-203-51-30-76.nsw.bigpond.net.au ([203.51.30.76]:18427 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S261799AbSKRJbn>; Mon, 18 Nov 2002 04:31:43 -0500
Message-ID: <3DD8B521.19184544@eyal.emu.id.au>
Date: Mon, 18 Nov 2002 20:38:41 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-rc1-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: RTL8139D support for 2.4?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently got a local (Australian, NetComm) NIC that uses a 8139D.
The standard 8139too seems to work with it but I wonder if I can
get something more out of a driver that has extra support.

The vendor supplies a driver in
	http://www.netcomm.com.au/one/support/drivers/NP1100_4.exe
which contains
	np11004.c

This is a modified rtl8139.c, based on a reasonably old version
	1.11 7/14/2000
The latest rtl8139.c I found is
	1.20 6/21/2002

2.4 does not anymore contain the rtl8139.c driver, but has moved
to the 8139too.c

Rather than use a vendor driver, is there support for this chip
in a current (2.4) driver?

Anyone knows the difference between the 8139C and 8139D?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
