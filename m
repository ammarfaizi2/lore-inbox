Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUJJAfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUJJAfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267928AbUJJAf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:35:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47797 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267916AbUJJAfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:35:23 -0400
Subject: weird APIC problem: irq 177 & irq 185
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Richard Rosenberg <richrosenberg@earthlink.net>
Content-Type: text/plain
Message-Id: <1097368522.1363.41.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 20:35:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone posted a bug report to alsa-user, and /proc/interrupts dies not
look right.  Kernel is 2.6.8 on Debian Sid, more info is forthcoming. 
It's a dual PIII-600.

There is no such thing as IRQ 177 and IRQ 185, correct?

           CPU0        CPU1
  0:   12931075        145 IIO-APIC-edge  timer
  1:       3516           1     IO-APIC-edge  i8042
  8:          4           0     IO-APIC-edge  rtc
  9:          0           0    IO-APIC-level  acpi
 11:          0           0    IO-APIC-level  uhci_hcd, uhci_hcd
 12:     222138         1     IO-APIC-edge  i8042
 14:      35418          2     IO-APIC-edge  ide0
 15:         24           1     IO-APIC-edge  ide1
177:      22627         1    IO-APIC-level  eth1
185:          0           0    IO-APIC-level  EMU10K1
NMI:          0          0
LOC:   12931345    12931386
ERR:         0
MIS:          0

Lee

