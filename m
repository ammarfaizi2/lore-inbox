Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265191AbSKSLUC>; Tue, 19 Nov 2002 06:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265192AbSKSLUC>; Tue, 19 Nov 2002 06:20:02 -0500
Received: from big-relay-1.ftel.co.uk ([192.150.140.123]:18826 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S265191AbSKSLUB>; Tue, 19 Nov 2002 06:20:01 -0500
Date: Tue, 19 Nov 2002 11:26:55 +0000
From: Ian G Batten <I.G.Batten@ftel.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Orinoco pcmcia fails in 2.5.47, OK in 2.5.43
Message-ID: <20021119112655.GL3905@himalia.ftel.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Fujitsu Telecommunications Europe Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting 2.5.47 on a Fujitsu B110 laptop, 233 Pentium MMX, Yenta
interface, I get this trace below.  It worked correctly under 2.5.43.
I'm compiling 2.5.47 to get the latest IRDA bits.

ian

Nov 18 19:03:02 lifebook cardmgr[506]: shutting down socket 0 
Nov 18 19:03:02 lifebook cardmgr[506]: executing: 'modprobe -r orinoco_cs'
Nov 18 19:03:02 lifebook cardmgr[506]: executing: 'modprobe -r orinoco'
Nov 18 19:03:02 lifebook cardmgr[506]: executing: 'modprobe -r hermes'
Nov 18 19:03:02 lifebook kernel: bad: scheduling while atomic!
Nov 18 19:03:02 lifebook kernel: Call Trace: [<c0114f9e>]  [<c0120e2f>]  [<c0120da0>]  [<c0203894>]  [<c0205b6b>]  [<c02076ec>]  [<c017a580>]  [<c016ce6c>]  [<c016cecd>]  [<c01714e8>]  [<c017154e>]  [<c0179f7e>]  [<c01718c1>]  [<c014177b>]  [<c0179f16>]  [<c014177b>]  [<c0179f16>]  [<c0142ac4>]  [<c0179f7e>]  [<c01718c1>]  [<c017f9db>]  [<c0171854>]  [<c0171865>]  [<c0115370>]  [<c017a983>]  [<c016e0c2>]  [<c0176763>]  [<c0155032>]  [<c015608e>]  [<c0154806>]  [<c014acbd>]  [<c015372c>]  [<c015372c>]  [<c014ada0>]  [<c014d10b>]  [<c014f3a7>]  [<c013f8f6>]  [<c0108d47>] 
Nov 18 19:03:06 lifebook cardmgr[506]: initializing socket 0
Nov 18 19:03:06 lifebook cardmgr[506]: socket 0: NETGEAR MA401 Wireless PC
Nov 18 19:03:06 lifebook cardmgr[506]: executing: 'modprobe hermes'
Nov 18 19:03:06 lifebook cardmgr[506]: + modprobe: Can't locate module hermes
Nov 18 19:03:06 lifebook cardmgr[506]: modprobe exited with status 255
Nov 18 19:03:06 lifebook cardmgr[506]: module /lib/modules/2.5.47/pcmcia/hermes.o not available 
Nov 18 19:03:06 lifebook cardmgr[506]: executing: 'modprobe orinoco'
Nov 18 19:03:06 lifebook cardmgr[506]: + modprobe: Can't locate module orinoco
Nov 18 19:03:06 lifebook cardmgr[506]: modprobe exited with status 255
Nov 18 19:03:06 lifebook cardmgr[506]: module /lib/modules/2.5.47/pcmcia/orinoco.o not available
Nov 18 19:03:06 lifebook cardmgr[506]: executing: 'modprobe orinoco_cs'
Nov 18 19:03:06 lifebook cardmgr[506]: + modprobe: Can't locate module orinoco_cs
Nov 18 19:03:07 lifebook cardmgr[506]: modprobe exited with status 255 
Nov 18 19:03:07 lifebook cardmgr[506]: module /lib/modules/2.5.47/pcmcia/orinoco_cs.o not available
Nov 18 19:03:08 lifebook cardmgr[506]: get dev info on socket 0 failed: Resource temporarily unavailable 
