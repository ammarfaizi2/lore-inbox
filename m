Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132701AbRDCV3c>; Tue, 3 Apr 2001 17:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132698AbRDCV3M>; Tue, 3 Apr 2001 17:29:12 -0400
Received: from [209.191.64.160] ([209.191.64.160]:1805 "HELO linuxninja.org")
	by vger.kernel.org with SMTP id <S132693AbRDCV3I>;
	Tue, 3 Apr 2001 17:29:08 -0400
Date: Tue, 3 Apr 2001 14:27:28 -0700 (PDT)
From: Tim Pepper <tpepper@linuxninja.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.3 irq routing conflict (VIA chipset)
Message-ID: <Pine.LNX.4.30.0104031414510.11170-100000@diego.linuxninja.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know there was a thread on this previously and I was thinking it had been
resolved (or was that only for a specific mobo mfg?).  When I finally got my
VIA chipset machine up to date with a 2.4.3 kernel I noticed the following on
boot up:

	PCI: Found IRQ 11 for device 00:0a.0
	IRQ routing conflict in pirq table for device 00:0a.0

The only device on irq 11 is an agp voodoo3 card.  I don't seem to see any
negative effects (unless what I believe is an unrelated scsi error is tied to
this somehow).

Should I just disregard this message and assume it's a mobo quirk?  The mobo
in question is an AOpen AX59Pro with the current bios.  I can run any test
code or send futher system info if desired...

Tim

--
************************************************************
*  tpepper@linuxninja dot org          * Venimus, Vidimus, *
*  http://www.linuxninja.org/~tpepper  * Dolavimus         *
************************************************************


