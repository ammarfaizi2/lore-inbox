Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTGOFDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTGOFDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:03:23 -0400
Received: from [203.199.140.162] ([203.199.140.162]:12550 "EHLO
	calvin.codito.com") by vger.kernel.org with ESMTP id S262273AbTGOFDV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:03:21 -0400
From: Amit Shah <shahamit@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1: ALSA problem
Date: Tue, 15 Jul 2003 10:48:17 +0530
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151048.17586.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know what the problem is exactly, since alsa shows it found one 
card... I'm using debian woody with alsa-base installed. Even if alsa shows 
one card detected, it doesn't play. (It doesn't recognize /dev/dsp?)


Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 
2003 UTC).
kobject_register failed for Ensoniq AudioPCI (-17)
Call Trace:
 [<c01f6b8a>] kobject_register+0x32/0x48
 [<c0248a1b>] bus_add_driver+0x3f/0xa0
 [<c0248e0a>] driver_register+0x36/0x3c
 [<c01fb236>] pci_register_driver+0x6a/0x90
 [<c04117ba>] alsa_card_ens137x_init+0xe/0x3c
 [<c03f86f5>] do_initcalls+0x39/0x94
 [<c03f876c>] do_basic_setup+0x1c/0x20
 [<c010509b>] init+0x33/0x188
 [<c0105068>] init+0x0/0x188
 [<c0107145>] kernel_thread_helper+0x5/0xc

ALSA device list:
  #0: Intel 82801BA-ICH2 at 0xe800, irq 17

-- 
Amit Shah
http://amitshah.nav.to/

Why do you want to read your code?
 The machine will.
                 -- Sunil Beta

