Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUAIVR7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbUAIVR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:17:59 -0500
Received: from p01m167.mxlogic.net ([66.179.109.167]:5251 "HELO
	p01m167.mxlogic.net") by vger.kernel.org with SMTP id S261735AbUAIVR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:17:58 -0500
Message-ID: <3FFF147E.F68F246D@amis.com>
Date: Fri, 09 Jan 2004 13:52:14 -0700
From: Eric Whiting <ewhiting@amis.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.1-mm1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: e1000 in 2.6.1-mm1 -- still broken?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MX-Spam: final=0.0100000000; heur=0.5000000000(0); stat=0.0100000000
X-MX-MAIL-FROM: <ewhiting@amis.com>
X-MX-SOURCE-IP: [207.141.5.253]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having trouble with e1000 in -mm1. (works in 2.6.1) The device is detected
and shows up and can be configured, but nothing ever goes out on the wire. 

Here is the device info:


07:01.1 Ethernet controller: Intel Corporation: Unknown device 1010 (rev 01)
        Subsystem: Intel Corporation: Unknown device 1011
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 49
        Memory at fe9e0000 (64-bit, non-prefetchable) [size=128K]
        I/O ports at dc00 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-


tcpdump shows no activity when I attempt to use the e1000 interface.
