Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262292AbTDALJH>; Tue, 1 Apr 2003 06:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbTDALJH>; Tue, 1 Apr 2003 06:09:07 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:61862 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262292AbTDALJG>; Tue, 1 Apr 2003 06:09:06 -0500
Subject: 2.5.66-mm2-1 freezes solid after init PCMCIA
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049196020.789.8.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 01 Apr 2003 13:20:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.5.66-mm2-1 freezes solid after initialising PCMCIA yenta. Next written
by hand:

PCI: Found IRQ 10 for device 00:0c.0
yenta 00:0c.0: Preassigned resource 3 busy, reconfiguring...
Yenta IRQ list 08d8, PCI irq10
Socket status: 30000006
PCI: Found IRQ 5 for device 00:0c.1
PCI: Sharing IRQ 5 with 00:09.0
yenta 00:0c.1: Preassigned resource 2 busy, reconfiguring...
yenta 00:0c.1: Preassigned resource 3 busy, reconfiguring...
Yenta IRQ list 08d8, PCI irq5
Socket status: 30000020

At this point, the machine hangs. This didn't happen with 2.5.66-mm1 or
2.5.66-mm2 (but it happens with 2.5.66-mm2-1). I'm 99% sure this is
caused by Dominik or Russell King PCMCIA patches.

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

